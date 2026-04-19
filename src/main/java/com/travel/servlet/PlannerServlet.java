package com.travel.servlet;

import com.travel.model.Destination;
import com.travel.model.Hotel;
import com.travel.model.Transport;
import com.travel.service.HotelService;
import com.travel.service.TravelPlannerService;
import com.travel.utils.DistanceCalculator;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.*;

@WebServlet("/PlannerServlet")
public class PlannerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String sourceCity = request.getParameter("sourceCity");
        String daysStr = request.getParameter("days");
        String budgetStr = request.getParameter("budget");
        String mood = request.getParameter("mood");

        if (sourceCity == null || daysStr == null || budgetStr == null || mood == null) {
            response.sendRedirect("planner.jsp");
            return;
        }

        int days;
        double budget;
        try {
            days = Integer.parseInt(daysStr.trim());
            budget = Double.parseDouble(budgetStr.trim());
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid days or budget value.");
            request.getRequestDispatcher("planner.jsp").forward(request, response);
            return;
        }

        // Get matching destinations
        List<Destination> destinations = TravelPlannerService.getMatchingDestinations(mood, days, budget, sourceCity);

        if (destinations.isEmpty()) {
            request.setAttribute("error", "No matching destinations found for your preferences. Try increasing budget or days.");
            request.getRequestDispatcher("planner.jsp").forward(request, response);
            return;
        }

        // For the top destination, calculate everything
        Destination topDest = destinations.get(0);
        double[] srcCoords = DistanceCalculator.getCityCoords(sourceCity);
        double distance = DistanceCalculator.calculateDistance(
            srcCoords[0], srcCoords[1], topDest.getLatitude(), topDest.getLongitude());

        List<Transport> transportOptions = TravelPlannerService.getTransportOptions(distance);
        List<Hotel> hotels = HotelService.getHotelsForDestination(topDest.getName(), days);
        List<String> itinerary = TravelPlannerService.generateItinerary(topDest.getName(), days, mood);

        // Store in session for booking
        session.setAttribute("sourceCity", sourceCity);
        session.setAttribute("days", days);
        session.setAttribute("budget", budget);
        session.setAttribute("mood", mood);
        session.setAttribute("destinations", destinations);
        session.setAttribute("topDestination", topDest);
        session.setAttribute("distance", distance);
        session.setAttribute("transportOptions", transportOptions);
        session.setAttribute("hotels", hotels);
        session.setAttribute("itinerary", itinerary);

        response.sendRedirect("result.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("planner.jsp");
    }
}
