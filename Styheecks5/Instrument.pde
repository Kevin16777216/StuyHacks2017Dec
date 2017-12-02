public class Instrument{
  Glide gainGlide;
  Glide frequencyGlide;
  AudioContext ac;
  WavePlayer wp;
  Gain g;
  float frequency;
  boolean isPlaying = false;
  public Instrument(float frequency){
   this.frequency = frequency;
   ac = new AudioContext();
   gainGlide = new Glide(ac, 0.0, 50);
   frequencyGlide = new Glide(ac, 20, 50);
   wp = new WavePlayer(ac, frequencyGlide, Buffer.SINE);
   g = new Gain(ac, 1, gainGlide);
   g.addInput(wp);
   ac.out.addInput(g);
   ac.start();
  }

}