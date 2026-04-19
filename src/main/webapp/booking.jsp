<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.travel.model.*,java.util.*" %>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String fullName = (String) session.getAttribute("fullName");
    String sourceCity = (String) session.getAttribute("sourceCity");
    Integer days = (Integer) session.getAttribute("days");
    Destination topDest = (Destination) session.getAttribute("topDestination");
    Double distance = (Double) session.getAttribute("distance");
    List<Transport> transports = (List<Transport>) session.getAttribute("transportOptions");
    List<Hotel> hotels = (List<Hotel>) session.getAttribute("hotels");
    if (topDest == null) { response.sendRedirect("planner.jsp"); return; }

    java.time.LocalDate today = java.time.LocalDate.now();
    String minDate = today.plusDays(1).toString();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking – TravelBharat</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="booking-body">

<nav class="navbar">
    <div class="nav-brand">🗺️ TravelBharat</div>
    <div class="nav-links">
        <a href="result.jsp" class="nav-link"><i class="fas fa-arrow-left"></i> Back to Plan</a>
        <span class="nav-welcome">👋 <%= fullName %></span>
        <a href="LogoutServlet" class="nav-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</nav>

<div class="booking-container">

    <div class="booking-header">
        <h1>Complete Your Booking</h1>
        <p><%= sourceCity %> → <%= topDest.getName() %> • <%= days %> Days</p>

        <div class="booking-steps">
            <div class="step active"><span>1</span> Details</div>
            <div class="step-line"></div>
            <div class="step"><span>2</span> Payment</div>
            <div class="step-line"></div>
            <div class="step"><span>3</span> Ticket</div>
        </div>
    </div>

    <form action="BookingServlet" method="post" class="booking-form-wrapper" onsubmit="return validateForm()">

        <div class="booking-grid">

            <!-- Personal Details -->
            <div class="booking-section-card">
                <div class="bsec-header">
                    <i class="fas fa-user-circle"></i>
                    <h3>Passenger Details</h3>
                </div>
                <div class="bsec-body">
                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-user"></i> Full Name *</label>
                            <input type="text" name="passengerName" required placeholder="Enter full name"
                                   value="<%= fullName %>">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-birthday-cake"></i> Age *</label>
                            <input type="number" name="age" min="5" max="100" required placeholder="Your age">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-venus-mars"></i> Gender *</label>
                            <select name="gender" required>
                                <option value="" disabled selected>Select gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-users"></i> Number of Passengers *</label>
                            <input type="number" name="passengers" min="1" max="20" required
                                   placeholder="How many people?" id="passengersInput" onchange="updateCost()">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-phone"></i> Phone Number *</label>
                            <input type="tel" name="phone" required placeholder="+91 XXXXXXXXXX"
                                   pattern="[0-9]{10}" title="10 digit phone number">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-envelope"></i> Email Address *</label>
                            <input type="email" name="email" required placeholder="your@email.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-calendar"></i> Travel Start Date *</label>
                        <input type="date" name="travelDate" required min="<%= minDate %>">
                    </div>
                </div>
            </div>

            <!-- Transport Selection -->
            <div class="booking-section-card">
                <div class="bsec-header">
                    <i class="fas fa-car"></i>
                    <h3>Select Transport</h3>
                </div>
                <div class="bsec-body">
                    <div class="transport-select-grid">
                        <% for (Transport t : transports) { %>
                        <label class="transport-radio-card">
                            <input type="radio" name="transportMode" value="<%= t.getMode() %>"
                                   data-cost="<%= t.getCost() * 2 %>" onchange="updateCost()">
                            <div class="trc-content">
                                <div class="trc-icon"><%= t.getIcon() %></div>
                                <div class="trc-mode"><%= t.getMode() %></div>
                                <div class="trc-time">⏱ <%= t.getTravelTime() %></div>
                                <div class="trc-price">₹<%= String.format("%,.0f", t.getCost() * 2) %><br><small>(Return)</small></div>
                            </div>
                        </label>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Hotel Selection -->
            <div class="booking-section-card">
                <div class="bsec-header">
                    <i class="fas fa-hotel"></i>
                    <h3>Select Hotel</h3>
                </div>
                <div class="bsec-body">
                    <div class="hotel-select-list">
                        <% for (Hotel h : hotels) { %>
                        <label class="hotel-radio-card">
                            <input type="radio" name="hotelName" value="<%= h.getName() %>"
                                   data-cost="<%= h.getPricePerNight() * days %>" onchange="updateCost()">
                            <div class="hrc-content">
                                <div class="hrc-left">
                                    <div class="hrc-name"><%= h.getName() %></div>
                                    <div class="hrc-location">📍 <%= h.getLocation() %></div>
                                    <div class="hrc-amenities"><%= h.getAmenities() %></div>
                                </div>
                                <div class="hrc-right">
                                    <div class="hrc-rating"><%= h.getStars() %> <%= h.getRating() %></div>
                                    <div class="hrc-price">₹<%= String.format("%,.0f", h.getPricePerNight()) %>/night</div>
                                    <div class="hrc-total">₹<%= String.format("%,.0f", h.getPricePerNight() * days) %> total</div>
                                </div>
                            </div>
                        </label>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Cost Summary -->
            <div class="booking-section-card cost-card">
                <div class="bsec-header">
                    <i class="fas fa-receipt"></i>
                    <h3>Cost Summary</h3>
                </div>
                <div class="bsec-body">
                    <div class="cost-row"><span>Transport (return)</span><span id="costTransport">₹ —</span></div>
                    <div class="cost-row"><span>Hotel (<%= days %> nights)</span><span id="costHotel">₹ —</span></div>
                    <div class="cost-row"><span>Passengers</span><span id="costPassengers">×1</span></div>
                    <div class="cost-divider"></div>
                    <div class="cost-row total-row"><span>Total Amount</span><span id="costTotal">₹ —</span></div>
                </div>
            </div>

        </div>

        <div class="form-submit-row">
            <button type="submit" class="btn-proceed">
                <i class="fas fa-credit-card"></i> Proceed to Payment
            </button>
        </div>
    </form>
</div>

<footer class="footer">
    <p>© 2024 TravelBharat | Explore India with Confidence</p>
</footer>

<script>
let transportCost = 0;
let hotelCost = 0;
let passengers = 1;

function updateCost() {
    const tRadio = document.querySelector('input[name="transportMode"]:checked');
    const hRadio = document.querySelector('input[name="hotelName"]:checked');
    const pInput = document.getElementById('passengersInput');

    transportCost = tRadio ? parseFloat(tRadio.dataset.cost) : 0;
    hotelCost = hRadio ? parseFloat(hRadio.dataset.cost) : 0;
    passengers = pInput && pInput.value ? parseInt(pInput.value) : 1;

    const total = (transportCost + hotelCost) * passengers;

    document.getElementById('costTransport').textContent = tRadio ? '₹' + transportCost.toLocaleString('en-IN') : '₹ —';
    document.getElementById('costHotel').textContent = hRadio ? '₹' + hotelCost.toLocaleString('en-IN') : '₹ —';
    document.getElementById('costPassengers').textContent = '×' + passengers;
    document.getElementById('costTotal').textContent = total > 0 ? '₹' + total.toLocaleString('en-IN') : '₹ —';
}

function validateForm() {
    const tRadio = document.querySelector('input[name="transportMode"]:checked');
    const hRadio = document.querySelector('input[name="hotelName"]:checked');
    if (!tRadio) { alert('Please select a transport mode.'); return false; }
    if (!hRadio) { alert('Please select a hotel.'); return false; }
    return true;
}
</script>

</body>
</html>
