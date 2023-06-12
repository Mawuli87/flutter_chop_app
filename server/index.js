//imports from packages
const express = require("express");
const mongoose = require("mongoose");

//imports from other files
const authRouter = require("./routes/auth");

// INIT
const PORT = process.env.PORT || 3000;
const app = express();

//client - server
//database url
const DB =
  "mongodb+srv://mawuli:Tuesbeni1989.mongodb@cluster0.pq3ednh.mongodb.net/?retryWrites=true&w=majority";

//middleware
// middleware
app.use(express.json());
app.use(authRouter);

//database connection start
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

//database connections ends

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
