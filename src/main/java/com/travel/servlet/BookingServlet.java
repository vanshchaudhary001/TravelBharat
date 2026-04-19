package com.travel.servlet;

import com.travel.model.Booking;
import com.travel.model.Destination;
import com.travel.model.Hotel;
import com.travel.model.Transport;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("passengerName");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String passengersStr = request.getParameter("passengers");
        String transportMode = request.getParameter("transportMode");
        String hotelName = request.getParameter("hotelName");
        String travelDate = request.getParameter("travelDate");

        Destination dest = (Destination) session.getAttribute("topDestination");
        String sourceCity = (String) session.getAttribute("sourceCity");
        Integer days = (Integer) session.getAttribute("days");
        List<Transport> transports = (List<Transport>) session.getAttribute("transportOptions");
        List<Hotel> hotels = (List<Hotel>) session.getAttribute("hotels");

        int passengers = Integer.parseInt(passengersStr);
        int age = Integer.parseInt(ageStr);

        // Find selected transport cost
        double transportCost = 0;
        for (Transport t : transports) {
            if (t.getMode().equalsIgnoreCase(transportMode)) {
                transportCost = t.getCost() * 2; // return journey
                break;
            }
        }

        // Find hotel cost
        double hotelCost = 0;
        for (Hotel h : hotels) {
            if (h.getName().equals(hotelName)) {
                hotelCost = h.getPricePerNight() * days;
                break;
            }
        }

        double totalCost = (transportCost + hotelCost) * passengers;

        // Create booking
        Booking booking = new Booking();
        booking.setPassengerName(name);
        booking.setAge(age);
        booking.setGender(gender);
        booking.setPhone(phone);
        booking.setEmail(email);
        booking.setPassengers(passengers);
        booking.setSource(sourceCity);
        booking.setDestination(dest.getName());
        booking.setTransportMode(transportMode);
        booking.setHotelName(hotelName);
        booking.setTotalCost(totalCost);

        // Travel dates
        LocalDate start = LocalDate.parse(travelDate);
        LocalDate end = start.plusDays(days);
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd MMM yyyy");
        booking.setStartDate(start.format(fmt));
        booking.setEndDate(end.format(fmt));

        session.setAttribute("booking", booking);
        session.setAttribute("totalCost", totalCost);

        response.sendRedirect("payment.jsp");
    }
}
