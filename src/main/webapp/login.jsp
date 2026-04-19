<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TravelBharat – Login</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="login-body">

<div class="login-bg">
    <div class="login-overlay"></div>
    <div class="floating-elements">
        <span class="float-icon" style="top:10%;left:5%;animation-delay:0s">✈️</span>
        <span class="float-icon" style="top:20%;right:8%;animation-delay:1s">🏔️</span>
        <span class="float-icon" style="top:70%;left:10%;animation-delay:2s">🕌</span>
        <span class="float-icon" style="top:80%;right:6%;animation-delay:0.5s">🌴</span>
        <span class="float-icon" style="top:45%;left:3%;animation-delay:1.5s">🏖️</span>
        <span class="float-icon" style="top:35%;right:3%;animation-delay:2.5s">⛰️</span>
    </div>
</div>

<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <div class="logo-icon">🗺️</div>
            <h1 class="logo-text">TravelBharat</h1>
            <p class="logo-tagline">Discover India, One Journey at a Time</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i>
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="LoginServlet" method="post" class="login-form">
            <div class="form-group">
                <label for="username"><i class="fas fa-user"></i> Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required autocomplete="off">
            </div>
            <div class="form-group">
                <label for="password"><i class="fas fa-lock"></i> Password</label>
                <div class="password-wrapper">
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    <span class="toggle-password" onclick="togglePassword()">
                        <i class="fas fa-eye" id="eyeIcon"></i>
                    </span>
                </div>
            </div>
            <button type="submit" class="btn-login">
                <i class="fas fa-plane-departure"></i> Begin Journey
            </button>
        </form>

        <div class="login-hint">
            <p>Demo credentials: <strong>vansh</strong> / <strong>vansh123</strong></p>
        </div>

        <div class="login-destinations">
            <span>🏔️ Manali</span>
            <span>🕌 Agra</span>
            <span>🏖️ Goa</span>
            <span>🌄 Jaipur</span>
            <span>🙏 Varanasi</span>
        </div>
    </div>
</div>

<script>
function togglePassword() {
    const pwd = document.getElementById('password');
    const icon = document.getElementById('eyeIcon');
    if (pwd.type === 'password') {
        pwd.type = 'text';
        icon.classList.replace('fa-eye', 'fa-eye-slash');
    } else {
        pwd.type = 'password';
        icon.classList.replace('fa-eye-slash', 'fa-eye');
    }
}
</script>
</body>
</html>
