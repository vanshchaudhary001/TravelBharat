<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.travel.model.*,com.travel.service.*,java.util.*" %>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String fullName = (String) session.getAttribute("fullName");
    String sourceCity = (String) session.getAttribute("sourceCity");
    Integer days = (Integer) session.getAttribute("days");
    Double budget = (Double) session.getAttribute("budget");
    String mood = (String) session.getAttribute("mood");
    Destination topDest = (Destination) session.getAttribute("topDestination");
    Double distance = (Double) session.getAttribute("distance");
    List<Transport> transports = (List<Transport>) session.getAttribute("transportOptions");
    List<Hotel> hotels = (List<Hotel>) session.getAttribute("hotels");
    List<String> itinerary = (List<String>) session.getAttribute("itinerary");
    List<Destination> destinations = (List<Destination>) session.getAttribute("destinations");

    if (topDest == null) {
        response.sendRedirect("planner.jsp");
        return;
    }
    String[] moodEmojis = {"Adventure","🧗","Religious","🙏","Hill Station","🏔️","Relaxation","🧘","Family","👨‍👩‍👧","Heritage","🏛️","Honeymoon","💑","Cultural","🎭"};
    String moodEmoji = "🌍";
    for (int i = 0; i < moodEmojis.length - 1; i += 2) {
        if (moodEmojis[i].equals(mood)) { moodEmoji = moodEmojis[i+1]; break; }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Travel Plan – TravelBharat</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="result-body">

<nav class="navbar">
    <div class="nav-brand">🗺️ TravelBharat</div>
    <div class="nav-links">
        <a href="planner.jsp" class="nav-link"><i class="fas fa-arrow-left"></i> Plan Again</a>
        <span class="nav-welcome">👋 <%= fullName %></span>
        <a href="LogoutServlet" class="nav-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</nav>

<div class="result-container">

    <!-- Trip Summary Banner -->
    <div class="trip-banner">
        <div class="trip-banner-content">
            <div class="trip-route">
                <span class="city-from">📍 <%= sourceCity %></span>
                <span class="route-arrow">✈️ ──────────</span>
                <span class="city-to">🏁 <%= topDest.getName() %></span>
            </div>
            <div class="trip-meta">
                <span><%= moodEmoji %> <%= mood %></span>
                <span>📅 <%= days %> Days</span>
                <span>💰 ₹<%= String.format("%,.0f", budget) %></span>
                <span>📍 <%= String.format("%.0f", distance) %> KM</span>
            </div>
        </div>
    </div>

    <!-- Destination Cards -->
    <% if (destinations != null && destinations.size() > 1) { %>
    <section class="section">
        <h2 class="section-title">✨ Recommended Destinations</h2>
        <p class="section-sub">We found <%= destinations.size() %> matching destinations for your <%= mood %> trip</p>
        <div class="dest-cards-row">
            <% for (int i = 0; i < destinations.size(); i++) {
                Destination d = destinations.get(i);
                double[] srcC = com.travel.utils.DistanceCalculator.getCityCoords(sourceCity);
                double dist = com.travel.utils.DistanceCalculator.calculateDistance(srcC[0], srcC[1], d.getLatitude(), d.getLongitude());
                String[] gradients = {"linear-gradient(135deg,#667eea,#764ba2)","linear-gradient(135deg,#f093fb,#f5576c)","linear-gradient(135deg,#4facfe,#00f2fe)"};
            %>
            <div class="dest-card <%= i == 0 ? "dest-card-featured" : "" %>" style="background: <%= gradients[i % 3] %>">
                <% if (i == 0) { %><div class="featured-badge">⭐ Best Match</div><% } %>
                <div class="dest-card-emoji">
                    <% if (d.getName().equals("Manali") || d.getName().equals("Shimla") || d.getName().equals("Mussoorie") || d.getName().equals("Nainital") || d.getName().equals("Ooty") || d.getName().equals("Darjeeling") || d.getName().equals("Munnar") || d.getName().equals("Kasol") || d.getName().equals("Leh") || d.getName().equals("Gangtok")) { %>🏔️
                    <% } else if (d.getName().equals("Goa")) { %>🏖️
                    <% } else if (d.getName().equals("Jaipur") || d.getName().equals("Udaipur") || d.getName().equals("Jaisalmer") || d.getName().equals("Jodhpur")) { %>🏜️
                    <% } else if (d.getName().equals("Rishikesh") || d.getName().equals("Haridwar") || d.getName().equals("Varanasi") || d.getName().equals("Amritsar") || d.getName().equals("Pushkar")) { %>🙏
                    <% } else { %>🌍<% } %>
                </div>
                <h3><%= d.getName() %></h3>
                <p class="dest-state"><%= d.getState() %></p>
                <p class="dest-desc"><%= d.getDescription() %></p>
                <div class="dest-tags">
                    <% for (String m : d.getMoods()) { %>
                    <span class="tag"><%= m %></span>
                    <% } %>
                </div>
                <div class="dest-stat">
                    <span>📏 <%= String.format("%.0f", dist) %> km from <%= sourceCity %></span>
                    <span>📅 <%= d.getMinDays() %>-<%= d.getMaxDays() %> Days</span>
                </div>
            </div>
            <% } %>
        </div>
    </section>
    <% } %>

    <!-- Distance Info -->
    <section class="section">
        <div class="distance-banner">
            <div class="dist-route">
                <strong><%= sourceCity %></strong>
                <span class="dist-line">──── 🚗 ────</span>
                <strong><%= topDest.getName() %></strong>
            </div>
            <div class="dist-km"><%= String.format("%.0f", distance) %> KM</div>
            <div class="dist-note">Distance calculated using Haversine Formula</div>
        </div>
    </section>

    <!-- Transport Options -->
    <section class="section">
        <h2 class="section-title">🚗 Transport Options</h2>
        <p class="section-sub"><%= sourceCity %> → <%= topDest.getName() %> : <%= String.format("%.0f", distance) %> KM (one way)</p>
        <div class="transport-grid">
            <% for (Transport t : transports) { %>
            <div class="transport-card">
                <div class="transport-icon"><%= t.getIcon() %></div>
                <h3><%= t.getMode() %></h3>
                <div class="transport-details">
                    <div class="tdet"><span>Distance</span><strong><%= String.format("%.0f", t.getDistance()) %> km</strong></div>
                    <div class="tdet"><span>Travel Time</span><strong><%= t.getTravelTime() %></strong></div>
                    <div class="tdet"><span>Rate</span><strong>₹<%= t.getRatePerKm() %>/km</strong></div>
                    <div class="tdet price"><span>One-way Cost</span><strong>₹<%= String.format("%,.0f", t.getCost()) %></strong></div>
                </div>
            </div>
            <% } %>
        </div>
    </section>

    <!-- Day-wise Itinerary -->
    <section class="section">
        <h2 class="section-title">📅 Your Day-Wise Itinerary</h2>
        <p class="section-sub"><%= days %>-Day <%= mood %> plan for <%= topDest.getName() %></p>
        <div class="itinerary-list">
            <% int dayNum = 1; for (String day : itinerary) {
                String parts[] = day.split(":", 2);
            %>
            <div class="itinerary-item">
                <div class="day-badge">Day <%= dayNum %></div>
                <div class="day-content">
                    <% if (parts.length == 2) { %>
                    <% String[] activities = parts[1].trim().split("\\|"); %>
                    <% for (String act : activities) { %>
                    <% String[] stops = act.trim().split("→"); %>
                    <% for (String stop : stops) { if (!stop.trim().isEmpty()) { %>
                    <span class="activity-tag"><%= stop.trim() %></span>
                    <% } } %>
                    <% } %>
                    <% } %>
                </div>
            </div>
            <% dayNum++; } %>
        </div>
    </section>

    <!-- Hotels -->
    <section class="section">
        <h2 class="section-title">🏨 Recommended Hotels</h2>
        <p class="section-sub">Top picks near <%= topDest.getName() %> • <%= days %> night stay</p>
        <div class="hotel-grid">
            <% for (Hotel h : hotels) { %>
            <div class="hotel-card">
                <div class="hotel-header">
                    <div class="hotel-icon">🏨</div>
                    <div>
                        <h4 class="hotel-name"><%= h.getName() %></h4>
                        <p class="hotel-location">📍 <%= h.getLocation() %></p>
                    </div>
                </div>
                <div class="hotel-rating">
                    <span class="stars-text"><%= h.getStars() %></span>
                    <span class="rating-num"><%= h.getRating() %> / 5.0</span>
                </div>
                <div class="hotel-amenities"><%= h.getAmenities() %></div>
                <div class="hotel-price">
                    <span class="price-night">₹<%= String.format("%,.0f", h.getPricePerNight()) %><small>/night</small></span>
                    <span class="price-total">₹<%= String.format("%,.0f", h.getPricePerNight() * days) %> total</span>
                </div>
            </div>
            <% } %>
        </div>
    </section>

    <!-- Book Now Button -->
    <section class="section book-section">
        <div class="book-cta">
            <div class="book-summary">
                <h3>Ready to Book? 🎉</h3>
                <p><%= sourceCity %> → <%= topDest.getName() %> • <%= days %> Days • <%= mood %> Trip</p>
            </div>
            <a href="booking.jsp" class="btn-book-now">
                <i class="fas fa-ticket-alt"></i> Book Now
            </a>
        </div>
    </section>

</div>

<footer class="footer">
    <p>© 2024 TravelBharat | Explore India with Confidence</p>
</footer>

</body>
</html>
