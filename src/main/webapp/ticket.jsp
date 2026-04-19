<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.travel.model.*" %>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Boolean paymentSuccess = (Boolean) session.getAttribute("paymentSuccess");
    if (paymentSuccess == null || !paymentSuccess) {
        response.sendRedirect("payment.jsp");
        return;
    }
    Booking booking = (Booking) session.getAttribute("booking");
    if (booking == null) { response.sendRedirect("planner.jsp"); return; }
    String fullName = (String) session.getAttribute("fullName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Confirmed – TravelBharat</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="ticket-body">

<nav class="navbar no-print">
    <div class="nav-brand">🗺️ TravelBharat</div>
    <div class="nav-links">
        <a href="planner.jsp" class="nav-link"><i class="fas fa-home"></i> Plan New Trip</a>
        <span class="nav-welcome">👋 <%= fullName %></span>
        <a href="LogoutServlet" class="nav-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</nav>

<div class="ticket-container">

    <!-- Success Banner -->
    <div class="success-banner no-print">
        <div class="success-animation">
            <div class="checkmark-circle">
                <div class="checkmark">✓</div>
            </div>
        </div>
        <h2>Booking Confirmed! 🎉</h2>
        <p>Your trip to <strong><%= booking.getDestination() %></strong> is all set. Have a wonderful journey!</p>
    </div>

    <div class="booking-steps-bar no-print">
        <div class="step done"><span>✓</span> Details</div>
        <div class="step-line done-line"></div>
        <div class="step done"><span>✓</span> Payment</div>
        <div class="step-line done-line"></div>
        <div class="step active"><span>3</span> Ticket</div>
    </div>

    <!-- THE TICKET -->
    <div class="ticket" id="printTicket">

        <!-- Ticket Header -->
        <div class="ticket-header">
            <div class="ticket-brand">
                <span class="ticket-logo">🗺️ TravelBharat</span>
                <span class="ticket-tagline">Your Journey, Our Promise</span>
            </div>
            <div class="ticket-status">
                <span class="status-badge confirmed">✅ CONFIRMED</span>
                <span class="booking-id">Booking ID: <strong><%= booking.getBookingId() %></strong></span>
            </div>
        </div>

        <!-- Route Strip -->
        <div class="ticket-route">
            <div class="ticket-city">
                <div class="city-code"><%= booking.getSource().substring(0, Math.min(3, booking.getSource().length())).toUpperCase() %></div>
                <div class="city-name"><%= booking.getSource() %></div>
                <div class="city-date"><%= booking.getStartDate() %></div>
            </div>
            <div class="ticket-route-mid">
                <div class="transport-badge-big">
                    <% if ("Car".equals(booking.getTransportMode())) { %>🚗
                    <% } else if ("Bus".equals(booking.getTransportMode())) { %>🚌
                    <% } else if ("Train".equals(booking.getTransportMode())) { %>🚆
                    <% } else { %>✈️<% } %>
                </div>
                <div class="route-dots">✦ ─ ─ ─ ─ ─ ✦</div>
                <div class="transport-label"><%= booking.getTransportMode() %></div>
            </div>
            <div class="ticket-city">
                <div class="city-code"><%= booking.getDestination().substring(0, Math.min(3, booking.getDestination().length())).toUpperCase() %></div>
                <div class="city-name"><%= booking.getDestination() %></div>
                <div class="city-date"><%= booking.getEndDate() %></div>
            </div>
        </div>

        <!-- Dashed Separator -->
        <div class="ticket-separator">
            <div class="sep-circle left"></div>
            <div class="sep-dashes"></div>
            <div class="sep-circle right"></div>
        </div>

        <!-- Passenger Details Grid -->
        <div class="ticket-details-grid">
            <div class="tdet-item">
                <span class="tdet-label">Passenger Name</span>
                <span class="tdet-val"><%= booking.getPassengerName() %></span>
            </div>
            <div class="tdet-item">
                <span class="tdet-label">Age / Gender</span>
                <span class="tdet-val"><%= booking.getAge() %> / <%= booking.getGender() %></span>
            </div>
            <div class="tdet-item">
                <span class="tdet-label">Phone</span>
                <span class="tdet-val"><%= booking.getPhone() %></span>
            </div>
            <div class="tdet-item">
                <span class="tdet-label">Email</span>
                <span class="tdet-val"><%= booking.getEmail() %></span>
            </div>
            <div class="tdet-item">
                <span class="tdet-label">No. of Passengers</span>
                <span class="tdet-val"><%= booking.getPassengers() %></span>
            </div>
            <div class="tdet-item">
                <span class="tdet-label">Transport Mode</span>
                <span class="tdet-val"><%= booking.getTransportMode() %></span>
            </div>
            <div class="tdet-item">
                <span class="tdet-label">Hotel</span>
                <span class="tdet-val"><%= booking.getHotelName() %></span>
            </div>
            <div class="tdet-item">
                <span class="tdet-label">Travel Period</span>
                <span class="tdet-val"><%= booking.getStartDate() %> → <%= booking.getEndDate() %></span>
            </div>
        </div>

        <!-- Total Cost Section -->
        <div class="ticket-cost-bar">
            <div class="cost-label">Total Amount Paid</div>
            <div class="cost-value">₹<%= String.format("%,.0f", booking.getTotalCost()) %></div>
        </div>

        <!-- Ticket Footer -->
        <div class="ticket-footer">
            <div class="ticket-barcode">
                ||||| ||| || | ||| || ||||| || | || ||| |||||
                <br><small><%= booking.getBookingId() %></small>
            </div>
            <div class="ticket-qr-small">
                <svg viewBox="0 0 60 60" width="60" height="60" xmlns="http://www.w3.org/2000/svg">
                    <rect width="60" height="60" fill="white"/>
                    <rect x="3" y="3" width="15" height="15" fill="none" stroke="#000" stroke-width="2"/>
                    <rect x="6" y="6" width="9" height="9" fill="#000"/>
                    <rect x="42" y="3" width="15" height="15" fill="none" stroke="#000" stroke-width="2"/>
                    <rect x="45" y="6" width="9" height="9" fill="#000"/>
                    <rect x="3" y="42" width="15" height="15" fill="none" stroke="#000" stroke-width="2"/>
                    <rect x="6" y="45" width="9" height="9" fill="#000"/>
                    <rect x="21" y="3" width="3" height="3" fill="#000"/>
                    <rect x="27" y="3" width="3" height="3" fill="#000"/>
                    <rect x="33" y="3" width="3" height="3" fill="#000"/>
                    <rect x="21" y="9" width="3" height="3" fill="#000"/>
                    <rect x="33" y="9" width="3" height="3" fill="#000"/>
                    <rect x="21" y="15" width="3" height="3" fill="#000"/>
                    <rect x="27" y="15" width="3" height="3" fill="#000"/>
                    <rect x="3" y="21" width="3" height="3" fill="#000"/>
                    <rect x="9" y="21" width="3" height="3" fill="#000"/>
                    <rect x="21" y="21" width="3" height="3" fill="#000"/>
                    <rect x="27" y="21" width="3" height="3" fill="#000"/>
                    <rect x="33" y="21" width="3" height="3" fill="#000"/>
                    <rect x="39" y="21" width="3" height="3" fill="#000"/>
                    <rect x="21" y="27" width="3" height="3" fill="#000"/>
                    <rect x="33" y="27" width="3" height="3" fill="#000"/>
                    <rect x="45" y="27" width="3" height="3" fill="#000"/>
                    <rect x="21" y="33" width="3" height="3" fill="#000"/>
                    <rect x="27" y="33" width="3" height="3" fill="#000"/>
                    <rect x="33" y="33" width="3" height="3" fill="#000"/>
                    <rect x="21" y="39" width="3" height="3" fill="#000"/>
                    <rect x="27" y="45" width="3" height="3" fill="#000"/>
                    <rect x="33" y="39" width="3" height="3" fill="#000"/>
                    <rect x="39" y="45" width="3" height="3" fill="#000"/>
                    <rect x="45" y="39" width="3" height="3" fill="#000"/>
                    <rect x="51" y="45" width="3" height="3" fill="#000"/>
                    <rect x="51" y="33" width="3" height="3" fill="#000"/>
                    <rect x="39" y="33" width="3" height="3" fill="#000"/>
                    <rect x="45" y="51" width="3" height="3" fill="#000"/>
                    <rect x="51" y="51" width="3" height="3" fill="#000"/>
                    <rect x="27" y="51" width="3" height="3" fill="#000"/>
                    <rect x="33" y="51" width="3" height="3" fill="#000"/>
                </svg>
            </div>
            <div class="ticket-terms">
                <p>✅ Valid for mentioned date only</p>
                <p>📋 Show this ticket at check-in</p>
                <p>🚫 Non-refundable</p>
            </div>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="ticket-actions no-print">
        <button class="btn-print" onclick="window.print()">
            <i class="fas fa-print"></i> Print Ticket
        </button>
        <a href="planner.jsp" class="btn-new-trip">
            <i class="fas fa-plane"></i> Plan Another Trip
        </a>
        <a href="LogoutServlet" class="btn-logout-action">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>

</div>

<footer class="footer no-print">
    <p>© 2024 TravelBharat | Thank you for booking with us!</p>
</footer>

</body>
</html>
