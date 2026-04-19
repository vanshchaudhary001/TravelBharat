package com.travel.servlet;

import com.travel.model.Booking;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    private static final String CORRECT_CODE = "VANSH";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String confirmCode = request.getParameter("confirmCode");
        Booking booking = (Booking) session.getAttribute("booking");

        if (confirmCode != null && confirmCode.trim().toUpperCase().equals(CORRECT_CODE)) {
            booking.setStatus("Confirmed");
            session.setAttribute("booking", booking);
            session.setAttribute("paymentSuccess", true);
            response.sendRedirect("ticket.jsp");
        } else {
            session.setAttribute("paymentSuccess", false);
            session.setAttribute("paymentError", "Invalid confirmation code. Please enter: VANSH");
            response.sendRedirect("payment.jsp");
        }
    }
}
