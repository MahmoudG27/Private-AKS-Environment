import express from "express";
import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import mysql from "mysql2/promise";
import dotenv from "dotenv";

dotenv.config();
const app = express();
app.use(express.json());

// ---------------- ENV ----------------
const {
  DB_HOST,
  DB_PORT,
  DB_USER,
  DB_PASSWORD,
  DB_NAME,
  SECRET_KEY
} = process.env;

if (!SECRET_KEY) {
  console.error("SECRET_KEY is not set!");
  process.exit(1);
}

// ---------------- CONNECT TO MYSQL ----------------
const db = await mysql.createPool({
  host: DB_HOST,
  port: DB_PORT || 3306,
  user: DB_USER,
  password: DB_PASSWORD,
  database: DB_NAME
});

// ---------------- SIGNUP ----------------
app.post("/signup", async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) return res.status(400).json({ error: "Email and password required" });

    const hashed = await bcrypt.hash(password, 10);

    await db.query("INSERT INTO users(email, password) VALUES(?,?)", [email, hashed]);
    res.json({ message: "User created" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// ---------------- LOGIN ----------------
app.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) return res.status(400).json({ error: "Email and password required" });

    const [rows] = await db.query("SELECT * FROM users WHERE email=?", [email]);
    if (rows.length === 0) return res.status(400).json({ error: "User not found" });

    const user = rows[0];
    const match = await bcrypt.compare(password, user.password);
    if (!match) return res.status(401).json({ error: "Wrong password" });

    const token = jwt.sign({ id: user.id, email: user.email }, SECRET_KEY, { expiresIn: "1h" });
    res.json({ token });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// ---------------- HEALTH CHECK ----------------
app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

// ---------------- RUN SERVER ----------------
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Auth service running on port ${PORT}`));