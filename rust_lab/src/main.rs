use std::f32::consts::PI;
use std::i16;
use hound;


fn main() {
    let spec = hound::WavSpec {
        channels: 1,
        sample_rate: 4096*16,
        bits_per_sample: 16,
        sample_format: hound::SampleFormat::Int,
    };
    let high: i16 = 32767;
    let low: i16 = -32768;

    let mut samples: Vec<i16> = Vec::new();
    let mut writer = hound::WavWriter::create("music.wav", spec).unwrap();
    let mut l: i16;
    let mut n: i16;
    for o in 0..16 {
        n = 1024;
        for m in 0..4 {
            l = n;
            for k in 0..4 {
                for i in 0..64 {
                    for j in 0..(l/4) {
                        samples.push(high)
                    }
                    for j in 0..(l) {
                        samples.push(low)
                    }
                }
                l -= n/4;
            }
            n-=256;
        }
    }    
    for sample in samples.iter() {
        writer.write_sample(*sample).unwrap();
    }
}
