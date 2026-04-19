<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.travel.model.*" %>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String fullName = (String) session.getAttribute("fullName");
    Booking booking = (Booking) session.getAttribute("booking");
    if (booking == null) { response.sendRedirect("planner.jsp"); return; }
    Double totalCost = (Double) session.getAttribute("totalCost");
    String paymentError = (String) session.getAttribute("paymentError");
    session.removeAttribute("paymentError");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment – TravelBharat</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="payment-body">

<nav class="navbar">
    <div class="nav-brand">🗺️ TravelBharat</div>
    <div class="nav-links">
        <a href="booking.jsp" class="nav-link"><i class="fas fa-arrow-left"></i> Back</a>
        <span class="nav-welcome">👋 <%= fullName %></span>
        <a href="LogoutServlet" class="nav-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</nav>

<div class="payment-container">

    <div class="booking-steps-bar">
        <div class="step done"><span>✓</span> Details</div>
        <div class="step-line done-line"></div>
        <div class="step active"><span>2</span> Payment</div>
        <div class="step-line"></div>
        <div class="step"><span>3</span> Ticket</div>
    </div>

    <div class="payment-grid">

        <!-- Order Summary -->
        <div class="payment-card summary-card">
            <h3><i class="fas fa-receipt"></i> Order Summary</h3>
            <div class="summary-item"><span>Passenger</span><strong><%= booking.getPassengerName() %></strong></div>
            <div class="summary-item"><span>Route</span><strong><%= booking.getSource() %> → <%= booking.getDestination() %></strong></div>
            <div class="summary-item"><span>Transport</span><strong><%= booking.getTransportMode() %></strong></div>
            <div class="summary-item"><span>Hotel</span><strong><%= booking.getHotelName() %></strong></div>
            <div class="summary-item"><span>Passengers</span><strong><%= booking.getPassengers() %></strong></div>
            <div class="summary-item"><span>Travel Date</span><strong><%= booking.getStartDate() %></strong></div>
            <div class="summary-divider"></div>
            <div class="summary-total">
                <span>Total Amount</span>
                <strong class="total-amount">₹<%= String.format("%,.0f", booking.getTotalCost()) %></strong>
            </div>
        </div>

        <!-- QR Payment -->
        <div class="payment-card qr-card">
            <h3><i class="fas fa-qrcode"></i> Scan & Pay</h3>
            <p class="upi-label">Scan QR code using any UPI app</p>

            <!-- Static QR Code generated with CSS -->
            <div class="qr-container">
                <svg class="qr-svg" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
                    <!-- QR Frame -->
                    <rect width="200" height="200" fill="white"/>
                    <!-- Corner squares -->
                    <rect x="10" y="10" width="50" height="50" fill="none" stroke="#000" stroke-width="5"/>
                    <rect x="18" y="18" width="34" height="34" fill="#000"/>
                    <rect x="140" y="10" width="50" height="50" fill="none" stroke="#000" stroke-width="5"/>
                    <rect x="148" y="18" width="34" height="34" fill="#000"/>
                    <rect x="10" y="140" width="50" height="50" fill="none" stroke="#000" stroke-width="5"/>
                    <rect x="18" y="148" width="34" height="34" fill="#000"/>
                    <!-- Center pattern -->
                    <rect x="70" y="10" width="8" height="8" fill="#000"/>
                    <rect x="82" y="10" width="8" height="8" fill="#000"/>
                    <rect x="94" y="10" width="8" height="8" fill="#000"/>
                    <rect x="106" y="10" width="8" height="8" fill="#000"/>
                    <rect x="118" y="10" width="8" height="8" fill="#000"/>
                    <rect x="70" y="22" width="8" height="8" fill="#000"/>
                    <rect x="94" y="22" width="8" height="8" fill="#000"/>
                    <rect x="118" y="22" width="8" height="8" fill="#000"/>
                    <rect x="70" y="34" width="8" height="8" fill="#000"/>
                    <rect x="82" y="34" width="8" height="8" fill="#000"/>
                    <rect x="106" y="34" width="8" height="8" fill="#000"/>
                    <rect x="118" y="34" width="8" height="8" fill="#000"/>
                    <!-- Middle rows -->
                    <rect x="10" y="70" width="8" height="8" fill="#000"/>
                    <rect x="22" y="70" width="8" height="8" fill="#000"/>
                    <rect x="46" y="70" width="8" height="8" fill="#000"/>
                    <rect x="70" y="70" width="8" height="8" fill="#000"/>
                    <rect x="94" y="70" width="8" height="8" fill="#000"/>
                    <rect x="106" y="70" width="8" height="8" fill="#000"/>
                    <rect x="130" y="70" width="8" height="8" fill="#000"/>
                    <rect x="154" y="70" width="8" height="8" fill="#000"/>
                    <rect x="178" y="70" width="8" height="8" fill="#000"/>
                    <rect x="10" y="82" width="8" height="8" fill="#000"/>
                    <rect x="34" y="82" width="8" height="8" fill="#000"/>
                    <rect x="58" y="82" width="8" height="8" fill="#000"/>
                    <rect x="82" y="82" width="8" height="8" fill="#000"/>
                    <rect x="118" y="82" width="8" height="8" fill="#000"/>
                    <rect x="142" y="82" width="8" height="8" fill="#000"/>
                    <rect x="166" y="82" width="8" height="8" fill="#000"/>
                    <rect x="22" y="94" width="8" height="8" fill="#000"/>
                    <rect x="46" y="94" width="8" height="8" fill="#000"/>
                    <rect x="70" y="94" width="8" height="8" fill="#000"/>
                    <rect x="94" y="94" width="8" height="8" fill="#000"/>
                    <rect x="106" y="94" width="8" height="8" fill="#000"/>
                    <rect x="130" y="94" width="8" height="8" fill="#000"/>
                    <rect x="154" y="94" width="8" height="8" fill="#000"/>
                    <rect x="178" y="94" width="8" height="8" fill="#000"/>
                    <rect x="10" y="106" width="8" height="8" fill="#000"/>
                    <rect x="34" y="106" width="8" height="8" fill="#000"/>
                    <rect x="70" y="106" width="8" height="8" fill="#000"/>
                    <rect x="82" y="106" width="8" height="8" fill="#000"/>
                    <rect x="118" y="106" width="8" height="8" fill="#000"/>
                    <rect x="130" y="106" width="8" height="8" fill="#000"/>
                    <rect x="154" y="106" width="8" height="8" fill="#000"/>
                    <!-- Bottom section -->
                    <rect x="70" y="130" width="8" height="8" fill="#000"/>
                    <rect x="82" y="130" width="8" height="8" fill="#000"/>
                    <rect x="106" y="130" width="8" height="8" fill="#000"/>
                    <rect x="118" y="130" width="8" height="8" fill="#000"/>
                    <rect x="142" y="130" width="8" height="8" fill="#000"/>
                    <rect x="166" y="130" width="8" height="8" fill="#000"/>
                    <rect x="70" y="142" width="8" height="8" fill="#000"/>
                    <rect x="94" y="142" width="8" height="8" fill="#000"/>
                    <rect x="118" y="142" width="8" height="8" fill="#000"/>
                    <rect x="154" y="142" width="8" height="8" fill="#000"/>
                    <rect x="70" y="154" width="8" height="8" fill="#000"/>
                    <rect x="82" y="154" width="8" height="8" fill="#000"/>
                    <rect x="94" y="154" width="8" height="8" fill="#000"/>
                    <rect x="118" y="154" width="8" height="8" fill="#000"/>
                    <rect x="130" y="154" width="8" height="8" fill="#000"/>
                    <rect x="142" y="154" width="8" height="8" fill="#000"/>
                    <rect x="166" y="154" width="8" height="8" fill="#000"/>
                    <rect x="178" y="154" width="8" height="8" fill="#000"/>
                    <!-- UPI text in center -->
                    <rect x="80" y="78" width="40" height="40" fill="white" rx="4"/>
                    <text x="100" y="98" text-anchor="middle" font-family="Arial" font-size="9" font-weight="bold" fill="#f97316">UPI</text>
                    <text x="100" y="110" text-anchor="middle" font-family="Arial" font-size="6" fill="#000">TRAVEL</text>
                    <text x="100" y="119" text-anchor="middle" font-family="Arial" font-size="6" fill="#000">BHARAT</text>
                </svg>
                <p class="qr-upi">travelbharat@upi</p>
                <p class="qr-amount"><strong>₹<%= String.format("%,.0f", booking.getTotalCost()) %></strong></p>
            </div>

            <div class="upi-apps">
                <div class="upi-app">📱 GPay</div>
                <div class="upi-app">💸 PhonePe</div>
                <div class="upi-app">🏦 Paytm</div>
                <div class="upi-app">🔷 BHIM</div>
            </div>

            <button class="btn-paid" onclick="showConfirmDialog()">
                <i class="fas fa-check-circle"></i> I Have Paid
            </button>
        </div>
    </div>

    <!-- Confirmation Dialog -->
    <div class="confirm-overlay" id="confirmOverlay" style="display:none">
        <div class="confirm-dialog">
            <div class="confirm-icon">🔐</div>
            <h3>Enter Confirmation Code</h3>
            <p>Please enter the payment confirmation code sent to your phone/email</p>

            <% if (paymentError != null) { %>
            <div class="alert alert-error"><i class="fas fa-times-circle"></i> <%= paymentError %></div>
            <% } %>

            <form action="PaymentServlet" method="post">
                <input type="text" name="confirmCode" id="confirmCode"
                       placeholder="Enter code here" class="confirm-input" autocomplete="off">
                <div class="confirm-hint">💡 Hint: Code is <strong>VANSH</strong></div>
                <div class="confirm-btns">
                    <button type="button" class="btn-cancel" onclick="hideConfirmDialog()">Cancel</button>
                    <button type="submit" class="btn-confirm">Verify & Confirm</button>
                </div>
            </form>
        </div>
    </div>

</div>

<footer class="footer">
    <p>© 2024 TravelBharat | Secure Payments</p>
</footer>

<script>
function showConfirmDialog() {
    document.getElementById('confirmOverlay').style.display = 'flex';
}
function hideConfirmDialog() {
    document.getElementById('confirmOverlay').style.display = 'none';
}
<% if (paymentError != null) { %>
window.onload = function() { showConfirmDialog(); };
<% } %>
</script>

</body>
</html>
