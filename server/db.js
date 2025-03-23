const Pool = require("pg").Pool;

const pool = new Pool({
  user: "postgres",
  password: "Zeyu1234",
  host: "localhost",
  port: 5432,
  database: "hotel_management"
});

module.exports = pool;