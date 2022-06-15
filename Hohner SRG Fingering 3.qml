import QtQuick 2.0
import MuseScore 3.0

MuseScore {
 menuPath: "Plugins.Hohner SRG Fingering"
 version: "2.0"
 description: qsTr("Hohner Soprano Recorder German Fingering.")

 function hohner_soprano_recorder_german_fingering(){
  //Font "Hohner Soprano Recorder" note mapping "do(C) <-> mi(E) over sharp" "q2w3er5t6y7ui9o0pzsxdcfvbhnj"
  var fingerings = ["q","2","w","3","e","r","5","t","6","y","7","u","i","9","o","0","p","z","s","x","d","c","f","v","b","h","n","j"];

  var cursor = curScore.newCursor();
  var startStaff;
  var endStaff;
  var endTick;
  var fullScore = false;

  cursor.rewind(1);
  if (!cursor.segment) { 
   // no selection
   console.log("No Selection - FullScore")
   fullScore = true;
   // start with 1st staff
   startStaff = 0; 
   // end with last
   endStaff = curScore.nstaves - 1;
  } else {
   // get start and end staff and tick
   console.log("Selection -")
   startStaff = cursor.staffIdx;
   cursor.rewind(2);
   if (cursor.tick == 0) {
    // this happens when the selection includes
    // the last measure of the score.
    // rewind(2) goes behind the last segment (where
    // there's none) and sets tick=0
    endTick = curScore.lastSegment.tick + 1;
   } else {
    endTick = cursor.tick;
   }
   endStaff = cursor.staffIdx;
  }

  console.log("Range: " + startStaff + " - " + endStaff + " - " + endTick)

  //Walk trought the score
  for (var staffIdx = startStaff; staffIdx <= endStaff; staffIdx++) {
   console.log("StaffIdx "+staffIdx);
  }
   
  //Walk trought the score
  //Only staff 0, to restore commnet next endStaff
  endStaff=0;
  for (var staff = startStaff; staff <= endStaff; staff++) {
   console.log("Staff "+staff);
   //STAFF = recorder?
   //Only voice 0, to restore 4->1
   for (var voice = 0; voice < 1; voice++) {
    console.log("Voice "+voice);
    cursor.rewind(1); // beginning of selection
    cursor.voice = voice;
    cursor.staffIdx = staff;
    if (fullScore) // no selection
     cursor.rewind(0); // beginning of score
    while (cursor.segment && (fullScore || cursor.tick < endTick)) {
     //console.log("Cursor "+cursor.element.type+" Search "+Element.CHORD);
     if (cursor.element && cursor.element.type == Element.CHORD) {
      var note=cursor.element.notes[0];
      var index=note.pitch-72;
				  //offsetY from 5 in lower pitch, to 11 in higher pitch
				  var offsetY=(index/28)*7+5;    
      if(index >= 0 && index < fingerings.length){ 
       console.log("Index "+index+" Letter "+ fingerings[index] + " Offset Y <", offsetY, ">");
       var text=newElement(Element.FINGERING);
       text.text = fingerings[index];
       text.color = "#000000";
       text.fontFace="Hohner Soprano Recorder";
       text.fontSize=18;
       cursor.add(text);
       text.offsetX = 0;
       text.offsetY = offsetY;
      }
      //}
     } // end if CHORD
     cursor.next();
    } // end while segment
   } // end for voice
  } // end for staff
 }



 onRun: {
  if (typeof curScore !== 'undefined') {
   hohner_soprano_recorder_german_fingering();
  }
  Qt.quit();
 } // end onRun
}