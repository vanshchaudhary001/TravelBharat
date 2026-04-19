package com.travel.model;

public class Hotel {
    private String name;
    private double pricePerNight;
    private double rating;
    private String location;
    private String amenities;

    public Hotel(String name, double pricePerNight, double rating, String location, String amenities) {
        this.name = name;
        this.pricePerNight = pricePerNight;
        this.rating = rating;
        this.location = location;
        this.amenities = amenities;
    }

    public String getName() { return name; }
    public double getPricePerNight() { return pricePerNight; }
    public double getRating() { return rating; }
    public String getLocation() { return location; }
    public String getAmenities() { return amenities; }
    public String getStars() {
        int full = (int) rating;
        String stars = "";
        for (int i = 0; i < full; i++) stars += "★";
        if (rating - full >= 0.5) stars += "½";
        return stars;
    }
}
