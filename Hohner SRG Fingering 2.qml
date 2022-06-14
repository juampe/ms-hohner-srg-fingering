import QtQuick 2.0
import MuseScore 1.0

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

  //Check if there are a selector or is apply to full score
  cursor.rewind(1);
  if (!cursor.segment) { // no selection
   fullScore = true;
   startStaff = 0; // start with 1st staff
   endStaff = curScore.nstaves - 1; // and end with last
  } else {
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

  console.log(startStaff + " - " + endStaff + " - " + endTick)

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
      //console.log("Index "+ index);
      if(index >= 0 && index < fingerings.length){ 
       console.log("Index "+index+" Letter "+ fingerings[index]);
       var text=newElement(Element.STAFF_TEXT);
       text.text="<font size=\"18\"><font face=\"Hohner Soprano Recorder\">"+fingerings[index]+"</font></font>";
       text.color="#000000";
       text.pos.y=10;
       cursor.add(text);
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