package com.travel.model;

public class Transport {
    private String mode;
    private double ratePerKm;
    private double distance;
    private String travelTime;
    private double cost;
    private String icon;

    public Transport(String mode, double ratePerKm, double distance) {
        this.mode = mode;
        this.ratePerKm = ratePerKm;
        this.distance = distance;
        this.cost = Math.round(distance * ratePerKm);
        this.travelTime = calculateTime();
        this.icon = getIconForMode(mode);
    }

    private String calculateTime() {
        double speedKmh;
        switch (mode) {
            case "Car": speedKmh = 60; break;
            case "Bus": speedKmh = 45; break;
            case "Train": speedKmh = 80; break;
            default: speedKmh = 60;
        }
        double hours = distance / speedKmh;
        int h = (int) hours;
        int m = (int) ((hours - h) * 60);
        return h + "h " + m + "m";
    }

    private String getIconForMode(String mode) {
        switch (mode) {
            case "Car": return "🚗";
            case "Bus": return "🚌";
            case "Train": return "🚆";
            default: return "✈️";
        }
    }

    public String getMode() { return mode; }
    public double getRatePerKm() { return ratePerKm; }
    public double getDistance() { return distance; }
    public String getTravelTime() { return travelTime; }
    public double getCost() { return cost; }
    public String getIcon() { return icon; }
}
