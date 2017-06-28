//
//  ViewController.swift
//  Hello AudioKit
//
//  Created by Justin Bane on 6/28/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    let midi = AKMIDI()
    let clickSampler = AKMIDISampler()
    let mixer = AKMixer()
    let sequencer = AKSequencer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            try clickSampler.loadWav("beep")
        } catch {
            print("Error loading wav file")
        }
        
        clickSampler.enableMIDI(midi.client, name: "wav-in")
        mixer.connect(clickSampler)
        
        let track = sequencer.newTrack()
        
        track?.add(
            noteNumber: 88,
            velocity: 100,
            position: AKDuration(beats: Double(1)),
            duration: AKDuration(beats: Double(0.07)),
            channel: 1)
        sequencer.setLength(AKDuration(beats: Double(4)))
        sequencer.enableLooping()
        sequencer.setTempo(Double(160))
        
        AudioKit.output = mixer
        AudioKit.start()
        sequencer.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

