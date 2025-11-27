// src/public/ui.js

async function login() {
  const email = document.getElementById("login-email").value;
  const password = document.getElementById("login-pass").value;

  const res = await fetch("/api/login", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ email, password }),
  });

  const data = await res.json();

  if (res.ok) {
    alert("Login successful");
    document.getElementById("searchBox").style.display = "block";
  } else {
    alert(data.error || "Login failed");
  }
}

async function signup() {
  const email = document.getElementById("signup-email").value;
  const password = document.getElementById("signup-pass").value;

  const res = await fetch("/api/signup", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ email, password }),
  });

  const data = await res.json();

  if (res.ok) {
    alert("Signup successful — you can login now");
  } else {
    alert(data.error || "Signup failed");
  }
}

async function searchCity() {
  const city = document.getElementById("city").value;

  const res = await fetch(`/api/weather?city=${city}`);
  const data = await res.json();

  if (res.ok) {
    document.getElementById("result").innerHTML =
      `<h3>Weather in ${city}</h3>
       <p>Temp: ${data.temp}</p>
       <p>Status: ${data.description}</p>`;
  } else {
    alert(data.error || "City not found");
  }
}
