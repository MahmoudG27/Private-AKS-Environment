// src/server.js
import express from "express";
import path from "path";
import fetch from "node-fetch";
import dotenv from "dotenv";

dotenv.config();

const app = express();

const __dirname = path.resolve();
app.use(express.json());

// ===== ENV VARIABLES =====
const AUTH = process.env.AUTH_HOST;
const WEATHER = process.env.WEATHER_HOST;

// ===== STATIC UI =====
app.use("/", express.static(path.join(__dirname, "src/public")));

// ===== PROXY LOGIN =====
app.post("/api/login", async (req, res) => {
  try {
    const r = await fetch(`${AUTH}/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(req.body),
    });

    return res.status(r.status).json(await r.json());
  } catch (err) {
    return res.status(500).json({ error: "Auth service unreachable" });
  }
});

// ===== PROXY SIGNUP =====
app.post("/api/signup", async (req, res) => {
  try {
    const r = await fetch(`${AUTH}/signup`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(req.body),
    });

    return res.status(r.status).json(await r.json());
  } catch (err) {
    return res.status(500).json({ error: "Auth service unreachable" });
  }
});

// ===== PROXY SEARCH WEATHER =====
app.get("/api/weather", async (req, res) => {
  const city = req.query.city;

  try {
    const r = await fetch(`${WEATHER}/weather?city=${city}`);
    return res.status(r.status).json(await r.json());
  } catch (err) {
    return res.status(500).json({ error: "Weather service unreachable" });
  }
});

app.listen(80, () => console.log("UI is running on port 80"));
