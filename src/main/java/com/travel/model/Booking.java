package com.travel.model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Random;

public class Booking {
    private String bookingId;
    private String passengerName;
    private int age;
    private String gender;
    private String phone;
    private String email;
    private int passengers;
    private String source;
    private String destination;
    private String transportMode;
    private String hotelName;
    private double totalCost;
    private String startDate;
    private String endDate;
    private String status;

    public Booking() {
        this.bookingId = generateBookingId();
        this.status = "Confirmed";
    }

    private String generateBookingId() {
        Random r = new Random();
        return "TP" + (100000 + r.nextInt(900000));
    }

    public String getBookingId() { return bookingId; }
    public String getPassengerName() { return passengerName; }
    public int getAge() { return age; }
    public String getGender() { return gender; }
    public String getPhone() { return phone; }
    public String getEmail() { return email; }
    public int getPassengers() { return passengers; }
    public String getSource() { return source; }
    public String getDestination() { return destination; }
    public String getTransportMode() { return transportMode; }
    public String getHotelName() { return hotelName; }
    public double getTotalCost() { return totalCost; }
    public String getStartDate() { return startDate; }
    public String getEndDate() { return endDate; }
    public String getStatus() { return status; }

    public void setPassengerName(String passengerName) { this.passengerName = passengerName; }
    public void setAge(int age) { this.age = age; }
    public void setGender(String gender) { this.gender = gender; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setEmail(String email) { this.email = email; }
    public void setPassengers(int passengers) { this.passengers = passengers; }
    public void setSource(String source) { this.source = source; }
    public void setDestination(String destination) { this.destination = destination; }
    public void setTransportMode(String transportMode) { this.transportMode = transportMode; }
    public void setHotelName(String hotelName) { this.hotelName = hotelName; }
    public void setTotalCost(double totalCost) { this.totalCost = totalCost; }
    public void setStartDate(String startDate) { this.startDate = startDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }
    public void setStatus(String status) { this.status = status; }
}
