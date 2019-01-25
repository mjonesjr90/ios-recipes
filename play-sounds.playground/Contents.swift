import UIKit
import AVFoundation

//add AVAudioPlayerDelegate to the class

var audioPlayer: AVAudioPlayer?
let soundArray = [""] //put file names here, not including the extensions

func playSound(_ sender: UIButton) {
    let soundURL = Bundle.main.url(forResource: soundArray[sender.tag - 1], withExtension: "wav")!

    do {
        audioPlayer = try AVAudioPlayer(contentsOf: soundURL) //crete an audio player with the URL above
        guard let player = audioPlayer else { return }
        
        player.prepareToPlay()
        player.play() //play audio
    } catch let error as NSError {
        print(error)
    }
}
