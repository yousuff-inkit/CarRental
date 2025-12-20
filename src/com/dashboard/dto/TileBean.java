package com.dashboard.dto;

public class TileBean {
    private String title;
    private String description;
    private String url;
    private String icon;
    private String colorClass;

    public TileBean(String title, String description, String url, String icon, String colorClass) {
        this.title = title;
        this.description = description;
        this.url = url;
        this.icon = icon;
        this.colorClass = colorClass;
    }

    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public String getUrl() { return url; }
    public String getIcon() { return icon; }
    public String getColorClass() { return colorClass; }
}