import React from "react";
import Header from "./Header";
import First from "./First";
// import "./debug.css";

const Footer = () => (
  <footer className="footer pv4 ph3 ph5-m ph6-l mid-gray">
    <small className="f6 db tc">
      © 2019 <b className="ttu">Irving Place inc.</b>., All Rights Reserved
    </small>
  </footer>
);

const App = () => (
  <>
    <Header /> <First /> <Footer />
  </>
);

export default App;
