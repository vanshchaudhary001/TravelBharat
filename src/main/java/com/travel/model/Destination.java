package com.travel.model;

import java.util.List;

public class Destination {
    private String name;
    private String state;
    private double latitude;
    private double longitude;
    private List<String> moods;
    private int minDays;
    private int maxDays;
    private double minBudget;
    private String description;
    private String imageClass;

    public Destination(String name, String state, double latitude, double longitude,
                       List<String> moods, int minDays, int maxDays, double minBudget,
                       String description, String imageClass) {
        this.name = name;
        this.state = state;
        this.latitude = latitude;
        this.longitude = longitude;
        this.moods = moods;
        this.minDays = minDays;
        this.maxDays = maxDays;
        this.minBudget = minBudget;
        this.description = description;
        this.imageClass = imageClass;
    }

    public String getName() { return name; }
    public String getState() { return state; }
    public double getLatitude() { return latitude; }
    public double getLongitude() { return longitude; }
    public List<String> getMoods() { return moods; }
    public int getMinDays() { return minDays; }
    public int getMaxDays() { return maxDays; }
    public double getMinBudget() { return minBudget; }
    public String getDescription() { return description; }
    public String getImageClass() { return imageClass; }
}
