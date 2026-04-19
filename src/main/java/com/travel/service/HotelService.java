package com.travel.service;

import com.travel.model.Hotel;
import java.util.*;

public class HotelService {

    private static final String[][] HOTEL_DATA = {
        // {name, basePrice, location}
        {"The Grand Himalayan Retreat", "4500", "Near Main Market"},
        {"Royal Heritage Palace", "5200", "City Centre"},
        {"Shivalik Valley Resort", "3800", "Riverside"},
        {"Mountain View Inn", "2200", "Hill Top"},
        {"Sunrise Comfort Suites", "2800", "Near Bus Stand"},
        {"Hotel Maharaja Pride", "6000", "Central Park"},
        {"The Blue Lagoon Resort", "4200", "Lakeside"},
        {"Golden Sands Hotel", "3500", "Old City"},
        {"Himalayan Nest Lodge", "1800", "Forest Area"},
        {"Palace on Wheels Inn", "5500", "Heritage Zone"},
        {"Lotus Bloom Residency", "2600", "Sector 12"},
        {"The Meadows Resort", "3900", "NH-58"},
        {"Ganges View Guesthouse", "1500", "Ghats Area"},
        {"Desert Rose Hotel", "4100", "Near Fort"},
        {"Woodland Eco Resort", "2900", "Nature Zone"},
        {"Hotel Rajwada", "3200", "Old Market"},
        {"Summit Peak Hotel", "4700", "Hilltop View"},
        {"Tranquil Waters Resort", "5100", "Lake Area"},
        {"Silver Fern Boutique Hotel", "3600", "Mall Road"},
        {"The Spice Garden Inn", "2100", "Spice Market"},
        {"Cloudhill Manor", "4300", "Ridge Top"},
        {"The Crimson Fort Hotel", "4900", "Near Fort"},
        {"Breezy Pines Resort", "3100", "Pine Forest"},
        {"Hotel Swagat", "1600", "Station Road"},
        {"Mystic Valleys Resort", "5800", "Valley View"},
        {"Sunset Pavilion Hotel", "3300", "West End"},
        {"The Lotus Pond Resort", "4600", "Wetland Area"},
        {"Aravalli Hills Retreat", "2700", "Hillside"},
        {"Heritage Haveli Hotel", "5300", "Old Town"},
        {"Green Canopy Eco Lodge", "2000", "Jungle Area"},
        {"The Silk Route Inn", "3700", "Trade Zone"},
        {"Moonlight Beach Resort", "4800", "Beachfront"},
        {"Tiger Trail Resort", "5600", "Safari Zone"},
        {"Stargazer Camp Hotel", "2300", "Open Fields"},
        {"The Zenith Hotel", "4400", "City Hub"},
        {"Riverside Pebble Inn", "1900", "River Bank"},
        {"Cloud Nine Resort", "5000", "Sky View"},
        {"The Amber Fort Hotel", "6200", "Heritage District"},
        {"Peacock Valley Resort", "3400", "Garden Area"},
        {"The Ivory Tower Hotel", "5700", "Business District"},
        {"Sapphire Hills Lodge", "2500", "Hillside"},
        {"The Mango Grove Inn", "1700", "Countryside"},
        {"Falcon's Nest Hotel", "4100", "Cliff Side"},
        {"The Jasmine Court", "3800", "Flower Market"},
        {"River Song Resort", "2900", "Riverside"},
        {"The Terracotta Hotel", "3600", "Arts District"},
        {"Snowcap Chalet", "4200", "Near Ski Slopes"},
        {"The Banyan Tree Inn", "2100", "Village Road"},
        {"Horizon View Hotel", "3000", "Hilltop"},
        {"The Emerald Pool Resort", "5400", "Garden Valley"}
    };

    public static List<Hotel> getHotelsForDestination(String destination, int days) {
        Random random = new Random(destination.hashCode() + days);
        List<String[]> pool = new ArrayList<>(Arrays.asList(HOTEL_DATA));
        Collections.shuffle(pool, random);

        List<Hotel> selected = new ArrayList<>();
        for (int i = 0; i < 5 && i < pool.size(); i++) {
            String[] data = pool.get(i);
            double basePrice = Double.parseDouble(data[1]);
            // Add some randomness to price
            double price = basePrice + (random.nextInt(800) - 400);
            price = Math.max(1000, price);
            // Rating between 3.5 and 4.8
            double rating = 3.5 + (random.nextDouble() * 1.3);
            rating = Math.round(rating * 10.0) / 10.0;

            selected.add(new Hotel(
                data[0],
                Math.round(price),
                rating,
                data[2] + ", " + destination,
                getRandomAmenities(random)
            ));
        }
        return selected;
    }

    private static String getRandomAmenities(Random r) {
        String[] all = {"Free WiFi", "AC Rooms", "Swimming Pool", "Restaurant", "Gym",
                        "Room Service", "Parking", "Spa", "Rooftop Terrace", "Bar & Lounge",
                        "Laundry", "Concierge", "Garden View", "Mountain View", "Lake View"};
        List<String> amenities = new ArrayList<>(Arrays.asList(all));
        Collections.shuffle(amenities, r);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 4; i++) {
            if (i > 0) sb.append(", ");
            sb.append(amenities.get(i));
        }
        return sb.toString();
    }
}
