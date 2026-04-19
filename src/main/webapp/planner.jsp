<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String fullName = (String) session.getAttribute("fullName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Plan Your Trip – TravelBharat</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="planner-body">

<!-- Navbar -->
<nav class="navbar">
    <div class="nav-brand">🗺️ TravelBharat</div>
    <div class="nav-links">
        <span class="nav-welcome">👋 Welcome, <%= fullName %></span>
        <a href="LogoutServlet" class="nav-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</nav>

<!-- Hero Section -->
<div class="planner-hero">
    <div class="hero-content">
        <h1>Where do you want to <span class="highlight">explore?</span></h1>
        <p>Tell us your preferences and we'll craft the perfect Indian adventure for you</p>
    </div>
    <div class="hero-icons">
        <div class="hero-icon-card">🏔️<br><small>Hill Stations</small></div>
        <div class="hero-icon-card">🏖️<br><small>Beaches</small></div>
        <div class="hero-icon-card">🕌<br><small>Heritage</small></div>
        <div class="hero-icon-card">🙏<br><small>Religious</small></div>
        <div class="hero-icon-card">🌿<br><small>Nature</small></div>
    </div>
</div>

<div class="planner-container">
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <div class="planner-card">
        <div class="planner-card-header">
            <i class="fas fa-compass"></i>
            <h2>Plan My Trip</h2>
            <p>Fill in the details below to get personalised destinations</p>
        </div>

        <form action="PlannerServlet" method="post" class="planner-form">

            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-map-marker-alt"></i> Your Current City</label>
                    <input type="text" name="sourceCity" id="sourceCity"
                           placeholder="e.g. Delhi, Lucknow, Dadri, Mumbai..."
                           required autocomplete="off" list="citySuggestions">
                    <datalist id="citySuggestions">
                        <option value="Delhi">
                        <option value="Noida">
                        <option value="Dadri">
                        <option value="Ghaziabad">
                        <option value="Lucknow">
                        <option value="Mumbai">
                        <option value="Pune">
                        <option value="Bangalore">
                        <option value="Hyderabad">
                        <option value="Kolkata">
                        <option value="Chennai">
                        <option value="Jaipur">
                        <option value="Agra">
                        <option value="Varanasi">
                        <option value="Ahmedabad">
                        <option value="Bhopal">
                        <option value="Indore">
                        <option value="Patna">
                        <option value="Dehradun">
                        <option value="Amritsar">
                    </datalist>
                    <span class="form-hint">Enter any city/district in India</span>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-calendar-alt"></i> Number of Days</label>
                    <input type="number" name="days" min="1" max="30" placeholder="e.g. 5"
                           required value="">
                    <span class="form-hint">How many days can you travel?</span>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-rupee-sign"></i> Total Budget (₹)</label>
                    <input type="number" name="budget" min="1000" placeholder="e.g. 15000"
                           required value="">
                    <span class="form-hint">Include travel + stay + food</span>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-heart"></i> Travel Mood / Type</label>
                    <select name="mood" required>
                        <option value="" disabled selected>Select your vibe...</option>
                        <option value="Adventure">🧗 Adventure</option>
                        <option value="Religious">🙏 Religious / Spiritual</option>
                        <option value="Hill Station">🏔️ Hill Station</option>
                        <option value="Relaxation">🧘 Relaxation</option>
                        <option value="Family">👨‍👩‍👧 Family Trip</option>
                        <option value="Heritage">🏛️ Heritage / Cultural</option>
                        <option value="Honeymoon">💑 Honeymoon</option>
                        <option value="Cultural">🎭 Cultural</option>
                    </select>
                    <span class="form-hint">What kind of trip do you want?</span>
                </div>
            </div>

            <div class="form-submit-row">
                <button type="submit" class="btn-plan">
                    <i class="fas fa-search-location"></i> Find My Perfect Destination
                </button>
            </div>
        </form>
    </div>

    <!-- Popular Destinations Section -->
    <div class="popular-section">
        <h3>🌟 Popular Destinations in India</h3>
        <div class="dest-grid">
            <div class="dest-mini-card" style="background: linear-gradient(135deg, #667eea, #764ba2)">
                <div class="dest-emoji">🏔️</div>
                <h4>Manali</h4>
                <p>Himachal Pradesh</p>
            </div>
            <div class="dest-mini-card" style="background: linear-gradient(135deg, #f093fb, #f5576c)">
                <div class="dest-emoji">🏜️</div>
                <h4>Jaisalmer</h4>
                <p>Rajasthan</p>
            </div>
            <div class="dest-mini-card" style="background: linear-gradient(135deg, #4facfe, #00f2fe)">
                <div class="dest-emoji">🏖️</div>
                <h4>Goa</h4>
                <p>Beach Paradise</p>
            </div>
            <div class="dest-mini-card" style="background: linear-gradient(135deg, #43e97b, #38f9d7)">
                <div class="dest-emoji">⛩️</div>
                <h4>Rishikesh</h4>
                <p>Uttarakhand</p>
            </div>
            <div class="dest-mini-card" style="background: linear-gradient(135deg, #fa709a, #fee140)">
                <div class="dest-emoji">🕌</div>
                <h4>Agra</h4>
                <p>Uttar Pradesh</p>
            </div>
            <div class="dest-mini-card" style="background: linear-gradient(135deg, #a18cd1, #fbc2eb)">
                <div class="dest-emoji">🌊</div>
                <h4>Munnar</h4>
                <p>Kerala</p>
            </div>
        </div>
    </div>
</div>

<footer class="footer">
    <p>© 2024 TravelBharat | Explore India with Confidence</p>
</footer>

<script src="js/script.js"></script>
</body>
</html>
