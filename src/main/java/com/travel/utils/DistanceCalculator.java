package com.travel.utils;

import java.util.HashMap;
import java.util.Map;

public class DistanceCalculator {

    // Indian cities with lat/lng coordinates
    private static final Map<String, double[]> CITY_COORDS = new HashMap<>();

    static {
        // North India
        CITY_COORDS.put("Delhi", new double[]{28.6139, 77.2090});
        CITY_COORDS.put("New Delhi", new double[]{28.6139, 77.2090});
        CITY_COORDS.put("Noida", new double[]{28.5355, 77.3910});
        CITY_COORDS.put("Gurgaon", new double[]{28.4595, 77.0266});
        CITY_COORDS.put("Faridabad", new double[]{28.4089, 77.3178});
        CITY_COORDS.put("Ghaziabad", new double[]{28.6692, 77.4538});
        CITY_COORDS.put("Dadri", new double[]{28.5535, 77.5545});
        CITY_COORDS.put("Agra", new double[]{27.1767, 78.0081});
        CITY_COORDS.put("Lucknow", new double[]{26.8467, 80.9462});
        CITY_COORDS.put("Kanpur", new double[]{26.4499, 80.3319});
        CITY_COORDS.put("Varanasi", new double[]{25.3176, 82.9739});
        CITY_COORDS.put("Allahabad", new double[]{25.4358, 81.8463});
        CITY_COORDS.put("Prayagraj", new double[]{25.4358, 81.8463});
        CITY_COORDS.put("Meerut", new double[]{28.9845, 77.7064});
        CITY_COORDS.put("Mathura", new double[]{27.4924, 77.6737});
        CITY_COORDS.put("Jhansi", new double[]{25.4484, 78.5685});
        CITY_COORDS.put("Bareilly", new double[]{28.3670, 79.4304});
        CITY_COORDS.put("Moradabad", new double[]{28.8386, 78.7733});
        CITY_COORDS.put("Aligarh", new double[]{27.8974, 78.0880});
        CITY_COORDS.put("Gorakhpur", new double[]{26.7606, 83.3732});

        // Hill Stations
        CITY_COORDS.put("Manali", new double[]{32.2396, 77.1887});
        CITY_COORDS.put("Shimla", new double[]{31.1048, 77.1734});
        CITY_COORDS.put("Mussoorie", new double[]{30.4598, 78.0664});
        CITY_COORDS.put("Nainital", new double[]{29.3919, 79.4542});
        CITY_COORDS.put("Ooty", new double[]{11.4102, 76.6950});
        CITY_COORDS.put("Darjeeling", new double[]{27.0360, 88.2627});
        CITY_COORDS.put("Munnar", new double[]{10.0889, 77.0595});
        CITY_COORDS.put("Coorg", new double[]{12.3375, 75.8069});
        CITY_COORDS.put("Kasol", new double[]{32.0122, 77.3150});
        CITY_COORDS.put("Dalhousie", new double[]{32.5380, 75.9753});
        CITY_COORDS.put("Lansdowne", new double[]{29.8379, 78.6855});
        CITY_COORDS.put("Chakrata", new double[]{30.7000, 77.8667});

        // Rajasthan
        CITY_COORDS.put("Jaipur", new double[]{26.9124, 75.7873});
        CITY_COORDS.put("Udaipur", new double[]{24.5854, 73.7125});
        CITY_COORDS.put("Jodhpur", new double[]{26.2389, 73.0243});
        CITY_COORDS.put("Jaisalmer", new double[]{26.9157, 70.9083});
        CITY_COORDS.put("Pushkar", new double[]{26.4899, 74.5511});
        CITY_COORDS.put("Bikaner", new double[]{28.0229, 73.3119});
        CITY_COORDS.put("Ajmer", new double[]{26.4499, 74.6399});
        CITY_COORDS.put("Mount Abu", new double[]{24.5926, 72.7156});

        // Religious
        CITY_COORDS.put("Rishikesh", new double[]{30.0869, 78.2676});
        CITY_COORDS.put("Haridwar", new double[]{29.9457, 78.1642});
        CITY_COORDS.put("Mathura", new double[]{27.4924, 77.6737});
        CITY_COORDS.put("Vrindavan", new double[]{27.5794, 77.6972});
        CITY_COORDS.put("Tirupati", new double[]{13.6288, 79.4192});
        CITY_COORDS.put("Amritsar", new double[]{31.6340, 74.8723});
        CITY_COORDS.put("Bodh Gaya", new double[]{24.6961, 84.9912});
        CITY_COORDS.put("Kedarnath", new double[]{30.7346, 79.0669});
        CITY_COORDS.put("Badrinath", new double[]{30.7433, 79.4938});

        // South India
        CITY_COORDS.put("Mumbai", new double[]{19.0760, 72.8777});
        CITY_COORDS.put("Pune", new double[]{18.5204, 73.8567});
        CITY_COORDS.put("Bangalore", new double[]{12.9716, 77.5946});
        CITY_COORDS.put("Bengaluru", new double[]{12.9716, 77.5946});
        CITY_COORDS.put("Chennai", new double[]{13.0827, 80.2707});
        CITY_COORDS.put("Hyderabad", new double[]{17.3850, 78.4867});
        CITY_COORDS.put("Kochi", new double[]{9.9312, 76.2673});
        CITY_COORDS.put("Goa", new double[]{15.2993, 74.1240});
        CITY_COORDS.put("Mysuru", new double[]{12.2958, 76.6394});
        CITY_COORDS.put("Mysore", new double[]{12.2958, 76.6394});
        CITY_COORDS.put("Hampi", new double[]{15.3350, 76.4600});
        CITY_COORDS.put("Madurai", new double[]{9.9252, 78.1198});

        // East India
        CITY_COORDS.put("Kolkata", new double[]{22.5726, 88.3639});
        CITY_COORDS.put("Patna", new double[]{25.5941, 85.1376});
        CITY_COORDS.put("Bhubaneswar", new double[]{20.2961, 85.8245});
        CITY_COORDS.put("Puri", new double[]{19.8135, 85.8312});
        CITY_COORDS.put("Gangtok", new double[]{27.3389, 88.6065});

        // West & Central India
        CITY_COORDS.put("Ahmedabad", new double[]{23.0225, 72.5714});
        CITY_COORDS.put("Surat", new double[]{21.1702, 72.8311});
        CITY_COORDS.put("Somnath", new double[]{20.9089, 70.3844});
        CITY_COORDS.put("Vadodara", new double[]{22.3072, 73.1812});
        CITY_COORDS.put("Indore", new double[]{22.7196, 75.8577});
        CITY_COORDS.put("Bhopal", new double[]{23.2599, 77.4126});
        CITY_COORDS.put("Ujjain", new double[]{23.1765, 75.7885});
        CITY_COORDS.put("Khajuraho", new double[]{24.8318, 79.9199});
        CITY_COORDS.put("Pachmarhi", new double[]{22.4672, 78.4337});

        // Adventure/North-East
        CITY_COORDS.put("Leh", new double[]{34.1526, 77.5771});
        CITY_COORDS.put("Srinagar", new double[]{34.0837, 74.7973});
        CITY_COORDS.put("Gulmarg", new double[]{34.0484, 74.3805});
        CITY_COORDS.put("Shillong", new double[]{25.5788, 91.8933});
        CITY_COORDS.put("Kaziranga", new double[]{26.6638, 93.3664});
        CITY_COORDS.put("Dehradun", new double[]{30.3165, 78.0322});
    }

    /**
     * Haversine formula: calculates distance between two lat/lng points in km
     */
    public static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        final double R = 6371; // Earth's radius in km
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return Math.round(R * c);
    }

    public static double getDistanceBetweenCities(String city1, String city2) {
        double[] coords1 = getCityCoords(city1);
        double[] coords2 = getCityCoords(city2);
        return calculateDistance(coords1[0], coords1[1], coords2[0], coords2[1]);
    }

    public static double[] getCityCoords(String city) {
        // Try exact match first
        if (CITY_COORDS.containsKey(city)) {
            return CITY_COORDS.get(city);
        }
        // Try case-insensitive match
        for (Map.Entry<String, double[]> entry : CITY_COORDS.entrySet()) {
            if (entry.getKey().equalsIgnoreCase(city)) {
                return entry.getValue();
            }
        }
        // Default to Delhi if city not found
        return CITY_COORDS.get("Delhi");
    }

    public static boolean cityExists(String city) {
        if (CITY_COORDS.containsKey(city)) return true;
        for (String key : CITY_COORDS.keySet()) {
            if (key.equalsIgnoreCase(city)) return true;
        }
        return false;
    }

    public static Map<String, double[]> getAllCities() {
        return CITY_COORDS;
    }
}
