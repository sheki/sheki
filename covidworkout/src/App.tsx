import React, { useEffect, useState } from "react";
import YouTube from "react-youtube";
import "./App.css";

import shoulderStretch from "./images/shoulderStretch.jpg";
import underarmStretch from "./images/underarmstertch.jpg";
import fullsquat from "./images/fullsquat.jpg";
import rearhandclasp from "./images/rearhandclasp.jpg";
import hamstring from "./images/hamstring.webp";
import kneeleft from "./images/kneeleft.jpg";
import kneeright from "./images/kneeright.jpg";
import butterfly from "./images/butterfly.jpg";
import wheel from "./images/wheel.jpg";
import twistleft from "./images/twistleft.jpeg";
import twistright from "./images/twistright.jpeg";
import hellyeah from "./images/hellyeah.webp";

const list = [
  {
    videoId: "27F46WPVJBs",
    start: 25,
    image: shoulderStretch,
    duration: 60,
    title: "Shoulder Strech",
  },
  {
    videoId: "iiRMfb3Z9hg",
    start: 10,
    image: underarmStretch,
    duration: 60,
    title: "Shoulder Strech Back",
  },
  {
    videoId: "fuKDBPw8wQA",
    start: 20,
    image: rearhandclasp,
    duration: 60,
    title: "Rearhand Clasp",
  },
  {
    videoId: "_Yhyp-_hX2s",
    start: 49,
    image: fullsquat,
    duration: 60,
    title: "Full Squat",
  },
  {
    videoId: "YqeW9_5kURI",
    start: 31,
    image: hamstring,
    duration: 60,
    title: "Hamstring",
  },
  {
    videoId: "dW6SkvErFEE",
    start: 43,
    image: kneeleft,
    duration: 60,
    title: "Left Knee Lunge",
  },
  {
    videoId: "h2zgB93KANE",
    start: 6,
    image: kneeright,
    duration: 60,
    title: "Right Knee Lunge",
  },
  {
    videoId: "J8fFVOoqepc",
    start: 39,
    image: butterfly,
    duration: 60,
    title: "Butterfly on ground",
  },
  {
    videoId: "-KTsXHXMkJA",
    start: 25,
    image: wheel,
    duration: 30,
    title: "Wheel",
  },
  {
    videoId: "EelX_LwPHbA",
    start: 10,
    image: twistleft,
    duration: 60,
    title: "Lying Twist Left",
  },
  {
    videoId: "Tgxj_wdfu1k",
    start: 1,
    image: twistleft,
    duration: 60,
    title: "Lying Twist Left",
  },

  {
    videoId: "UPOT2tgY9QQ",
    start: 35,
    image: twistright,
    duration: 60,
    title: "Lying Twist Right",
  },

  {
    videoId: "A-Tod1_tZdU",
    start: 3,
    image: hellyeah,
    duration: 60,
    title: "Bonus",
  },

  {
    videoId: "THcyr9QZn7A",
    start: 10,
    image: "",
    duration: 500,
    title: "You DONE BOY",
  },
];

function App() {
  const [slideNumber, setSlideNumber] = useState(0);
  const [displayVideo, setDisplayVideo] = useState(false);

  useEffect(() => {
    const interval = setInterval(() => {
      setSlideNumber(slideNumber + 1);
      setDisplayVideo(false);
    }, 60 * 1000);
    let secondInterval = setInterval(() => {}, 1000 * 1000);
    if (!displayVideo) {
      clearInterval(secondInterval);
      secondInterval = setInterval(() => setDisplayVideo(true), 5 * 1000);
    }

    return () => {
      clearInterval(interval);
      clearInterval(secondInterval);
    };
  }, [slideNumber, displayVideo]);

  const item = list[slideNumber];
  return (
    <div className="App">
      <header className="App-header">
        <h1>{item.title}</h1>
        {displayVideo ? (
          <>
            <div className="App-right-left">
              <div className="App-item">
                <YoutubeVideo
                  key={item.videoId}
                  videoId={item.videoId}
                  start={item.start}
                />
              </div>
              <div className="App-item">
                <img src={item.image} alt="" style={{ maxWidth: "100%" }} />
              </div>
            </div>
            <h2>
              <Timer seconds={item.duration} key={item.title} />
            </h2>
          </>
        ) : (
          <Beep />
        )}
      </header>
    </div>
  );
}

function Beep() {
  // useEffect(() => beep(99, 210, 800));
  return (
    <div className="App-header">
      <h2>
        <Timer seconds={5} />
      </h2>
    </div>
  );
}

type TimerProps = {
  seconds: number;
};

function Timer(props: TimerProps) {
  const { seconds } = props;
  const [timer, setTimer] = useState(seconds);
  console.log(seconds);
  useEffect(() => {
    const interval = setInterval(() => setTimer(timer - 1), 1000);
    return () => clearInterval(interval);
  }, [timer, seconds]);

  return <div>{timer >= 0 ? timer : 0}</div>;
}

interface PlayerVars {
  autoplay?: 0 | 1;
  cc_load_policy?: 1;
  color?: "red" | "white";
  controls?: 0 | 1 | 2;
  disablekb?: 0 | 1;
  enablejsapi?: 0 | 1;
  end?: number;
  fs?: 0 | 1;
  hl?: string;
  iv_load_policy?: 1 | 3;
  list?: string;
  listType?: "playlist" | "search" | "user_uploads";
  loop?: 0 | 1;
  modestbranding?: 1;
  origin?: string;
  playlist?: string;
  playsinline?: 0 | 1;
  rel?: 0 | 1;
  showinfo?: 0 | 1;
  start?: number;
}

function YoutubeVideo({ videoId, start }: { videoId: string; start: number }) {
  const playerVars: PlayerVars = { start, autoplay: 1 };
  const opts = {
    height: "300",
    width: "300",
    playerVars,
  };

  return <YouTube videoId={videoId} opts={opts} />;
}

const a = new AudioContext(); // browsers limit the number of concurrent audio contexts, so you better re-use'em

function beep(vol: number, freq: number, duration: number) {
  const v = a.createOscillator();
  const u = a.createGain();
  v.connect(u);
  v.frequency.value = freq;
  v.type = "square";
  u.connect(a.destination);
  u.gain.value = vol * 0.01;
  v.start(a.currentTime);
  v.stop(a.currentTime + duration * 0.001);
}

export default App;
