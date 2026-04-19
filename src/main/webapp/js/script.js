// TravelBharat - Main JavaScript

document.addEventListener('DOMContentLoaded', function () {

    // Animate cards on scroll
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -40px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe all cards
    document.querySelectorAll('.dest-mini-card, .hotel-card, .transport-card, .itinerary-item')
        .forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(20px)';
            el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            observer.observe(el);
        });

    // Budget formatter
    const budgetInput = document.querySelector('input[name="budget"]');
    if (budgetInput) {
        budgetInput.addEventListener('input', function () {
            const val = parseInt(this.value);
            if (!isNaN(val)) {
                const hint = this.nextElementSibling;
                if (val < 5000) {
                    hint.textContent = '⚠️ Low budget - consider nearby destinations';
                    hint.style.color = '#f97316';
                } else if (val >= 5000 && val < 20000) {
                    hint.textContent = '✓ Good budget for 2-4 days trips';
                    hint.style.color = '#10b981';
                } else {
                    hint.textContent = '✓ Great budget - explore premium destinations!';
                    hint.style.color = '#10b981';
                }
            }
        });
    }

    // Days input helper
    const daysInput = document.querySelector('input[name="days"]');
    if (daysInput) {
        daysInput.addEventListener('input', function () {
            const val = parseInt(this.value);
            const hint = this.nextElementSibling;
            if (!isNaN(val)) {
                if (val < 2) hint.textContent = 'Great for quick getaways!';
                else if (val <= 5) hint.textContent = 'Perfect for a relaxing trip!';
                else if (val <= 10) hint.textContent = 'Great for exploring multiple spots!';
                else hint.textContent = 'Epic journey awaits! 🌟';
            }
        });
    }

    // Source city validation message
    const sourceInput = document.getElementById('sourceCity');
    if (sourceInput) {
        sourceInput.addEventListener('blur', function () {
            if (this.value.trim()) {
                const hint = this.nextElementSibling?.nextElementSibling || this.nextElementSibling;
                if (hint && hint.classList.contains('form-hint')) {
                    hint.textContent = `📍 Planning from: ${this.value}`;
                    hint.style.color = '#10b981';
                }
            }
        });
    }

    // Smooth form submit animation
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function () {
            const btn = this.querySelector('button[type="submit"]');
            if (btn) {
                btn.disabled = true;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Planning your trip...';
            }
        });
    });
});
