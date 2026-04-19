package com.travel.service;

import com.travel.model.Destination;
import com.travel.model.Transport;
import com.travel.utils.DistanceCalculator;

import java.util.*;

public class TravelPlannerService {

    private static final List<Destination> ALL_DESTINATIONS = new ArrayList<>();

    static {
        ALL_DESTINATIONS.add(new Destination("Manali", "Himachal Pradesh", 32.2396, 77.1887,
            Arrays.asList("Adventure", "Hill Station", "Honeymoon"),
            3, 7, 8000, "Snow-capped peaks, river valleys, and adventure sports paradise", "manali"));

        ALL_DESTINATIONS.add(new Destination("Shimla", "Himachal Pradesh", 31.1048, 77.1734,
            Arrays.asList("Hill Station", "Family", "Relaxation"),
            2, 5, 6000, "Colonial charm meets misty mountains in the Queen of Hills", "shimla"));

        ALL_DESTINATIONS.add(new Destination("Mussoorie", "Uttarakhand", 30.4598, 78.0664,
            Arrays.asList("Hill Station", "Honeymoon", "Relaxation"),
            2, 4, 5000, "The Queen of the Hills with stunning Himalayan views", "mussoorie"));

        ALL_DESTINATIONS.add(new Destination("Nainital", "Uttarakhand", 29.3919, 79.4542,
            Arrays.asList("Hill Station", "Family", "Relaxation"),
            2, 4, 5000, "A pear-shaped lake surrounded by pine-clad hills", "nainital"));

        ALL_DESTINATIONS.add(new Destination("Rishikesh", "Uttarakhand", 30.0869, 78.2676,
            Arrays.asList("Adventure", "Religious", "Relaxation"),
            2, 5, 4000, "Yoga capital of the world with thrilling river rafting", "rishikesh"));

        ALL_DESTINATIONS.add(new Destination("Haridwar", "Uttarakhand", 29.9457, 78.1642,
            Arrays.asList("Religious", "Family"),
            1, 3, 3000, "Sacred gateway to the gods on the Ganges", "haridwar"));

        ALL_DESTINATIONS.add(new Destination("Delhi", "Delhi", 28.6139, 77.2090,
            Arrays.asList("Family", "Cultural", "Heritage"),
            2, 5, 5000, "India's capital city with Mughal history and modern culture", "delhi"));

        ALL_DESTINATIONS.add(new Destination("Agra", "Uttar Pradesh", 27.1767, 78.0081,
            Arrays.asList("Heritage", "Family", "Cultural"),
            1, 3, 4000, "Home of the Taj Mahal, symbol of eternal love", "agra"));

        ALL_DESTINATIONS.add(new Destination("Jaipur", "Rajasthan", 26.9124, 75.7873,
            Arrays.asList("Heritage", "Cultural", "Family"),
            2, 5, 6000, "The Pink City with magnificent forts and vibrant bazaars", "jaipur"));

        ALL_DESTINATIONS.add(new Destination("Udaipur", "Rajasthan", 24.5854, 73.7125,
            Arrays.asList("Honeymoon", "Relaxation", "Heritage"),
            3, 5, 8000, "City of Lakes - the most romantic city in India", "udaipur"));

        ALL_DESTINATIONS.add(new Destination("Jaisalmer", "Rajasthan", 26.9157, 70.9083,
            Arrays.asList("Adventure", "Heritage", "Cultural"),
            2, 4, 7000, "The Golden City rising from the Thar Desert sands", "jaisalmer"));

        ALL_DESTINATIONS.add(new Destination("Jodhpur", "Rajasthan", 26.2389, 73.0243,
            Arrays.asList("Heritage", "Cultural", "Family"),
            2, 4, 6000, "The Blue City with the majestic Mehrangarh Fort", "jodhpur"));

        ALL_DESTINATIONS.add(new Destination("Goa", "Goa", 15.2993, 74.1240,
            Arrays.asList("Relaxation", "Adventure", "Honeymoon"),
            3, 7, 10000, "Beaches, nightlife and Portuguese heritage on the Arabian Sea", "goa"));

        ALL_DESTINATIONS.add(new Destination("Varanasi", "Uttar Pradesh", 25.3176, 82.9739,
            Arrays.asList("Religious", "Cultural", "Heritage"),
            2, 4, 4000, "The spiritual capital of India on the sacred Ganges", "varanasi"));

        ALL_DESTINATIONS.add(new Destination("Amritsar", "Punjab", 31.6340, 74.8723,
            Arrays.asList("Religious", "Cultural", "Family"),
            2, 4, 5000, "Home of the Golden Temple and the spirit of Punjab", "amritsar"));

        ALL_DESTINATIONS.add(new Destination("Darjeeling", "West Bengal", 27.0360, 88.2627,
            Arrays.asList("Hill Station", "Relaxation", "Family"),
            3, 5, 7000, "Tea gardens, toy train and Himalayan panoramas", "darjeeling"));

        ALL_DESTINATIONS.add(new Destination("Ooty", "Tamil Nadu", 11.4102, 76.6950,
            Arrays.asList("Hill Station", "Relaxation", "Family"),
            2, 4, 6000, "The Queen of Hill Stations with lush Nilgiri landscapes", "ooty"));

        ALL_DESTINATIONS.add(new Destination("Munnar", "Kerala", 10.0889, 77.0595,
            Arrays.asList("Hill Station", "Honeymoon", "Relaxation"),
            3, 5, 8000, "Rolling tea estates and misty mountains in God's Own Country", "munnar"));

        ALL_DESTINATIONS.add(new Destination("Leh", "Ladakh", 34.1526, 77.5771,
            Arrays.asList("Adventure", "Hill Station"),
            5, 10, 15000, "Land of High Passes with Buddhist monasteries and stark beauty", "leh"));

        ALL_DESTINATIONS.add(new Destination("Kasol", "Himachal Pradesh", 32.0122, 77.3150,
            Arrays.asList("Adventure", "Relaxation"),
            3, 6, 5000, "Mini Israel of India nestled in the Parvati Valley", "kasol"));

        ALL_DESTINATIONS.add(new Destination("Pushkar", "Rajasthan", 26.4899, 74.5511,
            Arrays.asList("Religious", "Cultural"),
            1, 3, 4000, "Holy lake city hosting the world's largest camel fair", "pushkar"));

        ALL_DESTINATIONS.add(new Destination("Coorg", "Karnataka", 12.3375, 75.8069,
            Arrays.asList("Relaxation", "Honeymoon", "Hill Station"),
            3, 5, 8000, "Scotland of India with coffee plantations and misty forests", "coorg"));

        ALL_DESTINATIONS.add(new Destination("Hampi", "Karnataka", 15.3350, 76.4600,
            Arrays.asList("Heritage", "Adventure", "Cultural"),
            2, 4, 5000, "A UNESCO World Heritage Site among ancient ruins", "hampi"));

        ALL_DESTINATIONS.add(new Destination("Khajuraho", "Madhya Pradesh", 24.8318, 79.9199,
            Arrays.asList("Heritage", "Cultural"),
            1, 2, 4000, "Temples of love and devotion from the Chandela dynasty", "khajuraho"));

        ALL_DESTINATIONS.add(new Destination("Gangtok", "Sikkim", 27.3389, 88.6065,
            Arrays.asList("Hill Station", "Adventure", "Family"),
            3, 6, 8000, "Capital of Sikkim with stunning Kanchenjunga views", "gangtok"));
    }

    public static List<Destination> getMatchingDestinations(String mood, int days, double budget, String sourceCity) {
        List<Destination> matches = new ArrayList<>();

        for (Destination dest : ALL_DESTINATIONS) {
            // Check mood match
            boolean moodMatch = dest.getMoods().stream()
                .anyMatch(m -> m.equalsIgnoreCase(mood) || mood.toLowerCase().contains(m.toLowerCase()));

            // Check budget match (budget should cover min per-day cost * days + transport)
            double[] srcCoords = DistanceCalculator.getCityCoords(sourceCity);
            double distance = DistanceCalculator.calculateDistance(
                srcCoords[0], srcCoords[1], dest.getLatitude(), dest.getLongitude());
            double transportCost = distance * 2; // rough estimate (bus)
            double hotelCost = dest.getMinBudget() * 0.6 * days;
            double totalMin = transportCost + hotelCost;

            boolean budgetMatch = budget >= totalMin;
            boolean daysMatch = days >= dest.getMinDays();

            // Skip same-as-source destination
            boolean notSame = !dest.getName().equalsIgnoreCase(sourceCity) &&
                              !sourceCity.toLowerCase().contains(dest.getName().toLowerCase());

            if (moodMatch && budgetMatch && daysMatch && notSame) {
                matches.add(dest);
            }
        }

        // Sort by mood relevance
        matches.sort((a, b) -> {
            boolean aExact = a.getMoods().stream().anyMatch(m -> m.equalsIgnoreCase(mood));
            boolean bExact = b.getMoods().stream().anyMatch(m -> m.equalsIgnoreCase(mood));
            if (aExact && !bExact) return -1;
            if (!aExact && bExact) return 1;
            return 0;
        });

        // Return top 3
        return matches.subList(0, Math.min(3, matches.size()));
    }

    public static List<Transport> getTransportOptions(double distance) {
        List<Transport> options = new ArrayList<>();
        if (distance < 2000) {
            options.add(new Transport("Car", 12.0, distance));
        }
        options.add(new Transport("Bus", 2.0, distance));
        options.add(new Transport("Train", 1.5, distance));
        return options;
    }

    public static List<String> generateItinerary(String destination, int days, String mood) {
        List<String> itinerary = new ArrayList<>();
        Map<String, String[][]> activities = getActivities();
        String[][] destActivities = activities.getOrDefault(destination, getGenericActivities(mood));

        Random r = new Random(destination.hashCode());
        List<String[][]> allActivities = new ArrayList<>(activities.values());

        for (int day = 1; day <= days; day++) {
            StringBuilder sb = new StringBuilder();
            sb.append("Day ").append(day).append(": ");

            if (day == 1) {
                sb.append("Arrive & Check-in | Explore nearby area | ");
            }
            if (day == days) {
                sb.append("Leisure morning | Packing & Checkout | Return journey");
            } else {
                String[] acts = destActivities[r.nextInt(destActivities.length)];
                sb.append(String.join(" → ", acts));
            }
            itinerary.add(sb.toString());
        }
        return itinerary;
    }

    private static String[][] getGenericActivities(String mood) {
        switch (mood.toLowerCase()) {
            case "adventure":
                return new String[][]{
                    {"River Rafting", "Bungee Jumping", "Camping"},
                    {"Trekking", "Rock Climbing", "Zipline"},
                    {"Paragliding", "Kayaking", "ATV Ride"}
                };
            case "religious":
                return new String[][]{
                    {"Morning Aarti", "Temple Visit", "Ghat Walk"},
                    {"Meditation Session", "Ashram Visit", "Yoga Class"},
                    {"River Bath", "Prasad Ceremony", "Evening Prayer"}
                };
            default:
                return new String[][]{
                    {"Sightseeing", "Local Market", "Photography"},
                    {"Museum Visit", "Heritage Walk", "Local Food Tour"},
                    {"Nature Walk", "Shopping", "Sunset View"}
                };
        }
    }

    private static Map<String, String[][]> getActivities() {
        Map<String, String[][]> map = new HashMap<>();

        map.put("Manali", new String[][]{
            {"Solang Valley", "Snow Activities", "Beas River Rafting"},
            {"Rohtang Pass", "Photography", "Local Market"},
            {"Hadimba Temple", "Vashisht Hot Springs", "Mall Road"},
            {"Paragliding", "Camping", "Bonfire Night"}
        });
        map.put("Shimla", new String[][]{
            {"Mall Road Walk", "Christ Church", "Jakhu Temple"},
            {"Kufri Adventure", "Ice Skating", "Local Food"},
            {"Toy Train Ride", "Viceregal Lodge", "Glen Forest"},
            {"Shopping", "Sunset Point", "Lakkar Bazaar"}
        });
        map.put("Rishikesh", new String[][]{
            {"River Rafting", "Laxman Jhula", "Ram Jhula"},
            {"Yoga & Meditation", "Beatles Ashram", "Triveni Ghat"},
            {"Bungee Jumping", "Giant Swing", "Flying Fox"},
            {"Neelkanth Temple", "Camping", "Ganga Aarti"}
        });
        map.put("Jaipur", new String[][]{
            {"Amber Fort", "City Palace", "Jantar Mantar"},
            {"Hawa Mahal", "Johari Bazaar", "Local Cuisine"},
            {"Nahargarh Fort", "Albert Hall Museum", "Pink City Walk"},
            {"Elephant Ride", "Craft Villages", "Sunset at Fort"}
        });
        map.put("Goa", new String[][]{
            {"Baga Beach", "Water Sports", "Nightlife"},
            {"Old Goa Churches", "Panjim Tour", "Spice Plantation"},
            {"Dolphin Watching", "Anjuna Flea Market", "Beach Shacks"},
            {"Dudhsagar Falls", "Fort Aguada", "Sunset Cruise"}
        });
        map.put("Agra", new String[][]{
            {"Taj Mahal Sunrise", "Agra Fort", "Mehtab Bagh"},
            {"Fatehpur Sikri", "Itmad-ud-Daulah", "Local Craft Shopping"},
            {"Marble Inlay Workshops", "Mughal Cuisine Tour", "Kinari Bazaar"}
        });
        map.put("Varanasi", new String[][]{
            {"Ganga Aarti", "Ghats Walk", "Boat Ride at Dawn"},
            {"Sarnath", "Kashi Vishwanath", "Silk Weaving Workshops"},
            {"Cremation Ghats", "Heritage Walk", "Classical Music Evening"}
        });
        map.put("Udaipur", new String[][]{
            {"City Palace", "Lake Pichola Boat", "Jag Mandir"},
            {"Saheliyon ki Bari", "Vintage Car Museum", "Fateh Sagar Lake"},
            {"Monsoon Palace", "Cultural Show", "Sunset at Lake"}
        });
        map.put("Leh", new String[][]{
            {"Pangong Lake", "Nubra Valley", "Khardung La Pass"},
            {"Monasteries Tour", "Magnetic Hill", "Hall of Fame"},
            {"Trekking", "Bike Ride", "Local Culture"},
            {"Stargazing Camp", "River Rafting", "Photo Safari"}
        });
        map.put("Nainital", new String[][]{
            {"Naini Lake Boating", "Snow View Point", "Mall Road"},
            {"Naina Devi Temple", "Zoo Visit", "Cable Car Ride"},
            {"Bhimtal Lake", "Sattal", "Local Market"},
            {"Eco Cave Gardens", "Hanuman Garhi", "Sunset Point"}
        });
        return map;
    }

    public static List<Destination> getAllDestinations() {
        return ALL_DESTINATIONS;
    }
}
