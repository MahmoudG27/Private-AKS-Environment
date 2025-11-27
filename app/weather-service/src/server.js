import express from "express";
import axios from "axios";

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 4000;
const WEATHER_API_KEY = process.env.WEATHER_API_KEY;

app.get("/weather", async (req, res) => {
  const city = req.query.city;
  if (!city) return res.status(400).json({ error: "City is required" });

  try {
    const response = await axios.get(
      `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${WEATHER_API_KEY}&units=metric`
    );

    const data = response.data;
    res.json({
      city: data.name,
      weather: data.weather[0].main,
      description: data.weather[0].description,
      temperature: data.main.temp,
      humidity: data.main.humidity
    });
  } catch (err) {
    res.status(500).json({ error: "Failed to fetch weather data" });
  }
});

app.get("/health", (req, res) => res.json({ status: "ok" }));

app.listen(PORT, () => console.log(`Weather service running on port ${PORT}`));