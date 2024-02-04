{
  /* < Image
source={
    require("../assets/warmups/Quadruped_Thoracic_Rotation.gif")}
style={{
    position: "relative",
  justifyContent: "center",
  alignItems: "center",
  alignSelf: "center",
  width: 400,
  height: 400,
}}
shouldPlay
isLooping
/ >

< Video
          source={require("../assets/exercises/McGill_Curl_Up.mp4")}
          style={{
              position: "relative",
            justifyContent: "center",
            alignItems: "center",
            alignSelf: "center",
            width: 400,
            height: 400,
          }}
          shouldPlay
          isLooping
        / > */
}
export const mediatypes = {
  VIDEO: "video",
  IMAGE: "image",
};

export const imageextensions = {
  GIF: "gif",
  JPEG: "jpeg",
  JPG: "jpg",
};

export const videoextensions = {
  MP4: "mp4",
};

export const days = {
  MONDAY: "Monday",
  TUESDAY: "Tuesday",
  WEDNESDAY: "Wednesday",
  THURSDAY: "Thursday",
  FRIDAY: "Friday",
  SATURDAY: "Saturday",
  SUNDAY: "Sunday",
};

export const jsondetails = {
  ID: "id",
  EXERCISEID: "exerciseid",
  MUSCLEGROUP: "musclegroup",
  EQUIPMENT: "equipment",
  EXERCISETYPE: "exercisetype",
  MUSCLECLASS: "muscleclass",
  NAME: "name",
  UTILITY: "utility",
  MECHANICS: "mechanics",
  FORCE: "force",
  PREPARATION: "preparation",
  EXECUTION: "execution",
  COMMENTS: "comments",
};

export const musclegroups = {
  BACK: "Back",
  CALVES: "Calves",
  CHEST: "Chest",
  FOREARMS: "Forearms",
  HIPS: "Hips",
  NECK: "Neck",
  SHOULDERS: "Shoulders",
  THIGHS: "Thighs",
  UPPERARMS: "UpperArms",
  WAIST: "Waist",
};

export const MuscleTypes = {
  ANTAGONISTSTABILIZERS: "antagonist stabilizers",
  DYNAMICSTABILIZERS: "dynamic stabilizers",
  OTHER: "other",
  STABILIZERS: "stabilizers",
  SYNERGISTS: "synergists",
  TARGET: "target",
};

export const muscles = {
  adductors: "Group of muscles mostly used for bringing the thighs together.",
  bicepsbrachii:
    "Two-headed muscle whose function is at the elbow where it flexes the forearm and supinates the forearm.",
  brachialis: "Flexes the elbow joint.",
  brachioradialis: "Flexes the forearm at the elbow.",
  deltoidanterior: "Assists the pectoralis major to flex the shoulder.",
  deltoidlateral:
    "Performs basic shoulder abduction when the shoulder is internally rotated, and performs shoulder transverse abduction when the shoulder is externally rotated.",
  deltoidposterior: "Assists the latissimus dorsi to extend the shoulder.",
  erectorspinae:
    "Group of muscles and tendons that straighten and rotate the back.",
  "forearm#pronation":
    "Many muscles, including the flexors and extensors of the digits, a flexor of the elbow (brachioradialis), and pronators and supinators that turn the hand to face down or upwards, respectively.",
  gastrocnemius:
    "Primarily involved in running, jumping and other fast movements of leg, and to a lesser degree in walking and standing.",
  gluteusmaximus:
    "External rotation and extension of the hip joint, supports the extended knee through the iliotibial tract, chief antigravity muscle in sitting and abduction of the hip.",
  gluteusmedius:
    "Abduction of the hip; preventing adduction of the hip. Medial/internal rotation and flexion of the hip (anterior fibers). Extension and Lateral/external rotation of the hip (posterior fibers) ",
  gluteusminimus:
    "Works in concert with gluteus medius: abduction of the hip; preventing adduction of the hip. Medial rotation of thigh.",
  gracilis:
    "Adducts, medially rotates (with hip flexion), laterally rotates, and flexes the hip; also aids in flexion of the knee",
  hamstrings:
    "Flexes the knee joint and extends the thigh to the backside of the body",
  "hip#abduction":
    "Group of muscles mostly used for bringing the thighs apart.",
  "hip#flexion":
    "Several muscles that bring your legs and trunk together in a flexion movement.",
  hipexernalrotators: "The thigh and knee rotate outward, away from the body.",
  iliopsoas: "Flexion of hip.",
  infraspinatus:
    "Externally rotates the humerus and stabilizes the shoulder joint.",
  latissimusdorsi:
    "Responsible for extension, adduction, transverse extension also known as horizontal abduction, flexion from an extended position, and (medial) internal rotation of the shoulder joint. It also has a synergistic role in extension and lateral flexion of the lumbar spine.",
  levatorscapulae: "Lifts the scapula.",
  obliques:
    "Responsible for the twisting of the trunk. Flexes the trunk, compresses its contents (bilaterally) and rotates it to the same side (unilaterally)",
  pectineus:
    "One of the muscles primarily responsible for hip flexion. It also adducts the thigh.",
  pectoralisclavicular:
    "Flexion, adduction, and internal rotation of the humerus.",
  pectoralisminor:
    "Stabilizes the scapula by drawing it inferiorly and anteriorly against the thoracic wall, raises ribs in inspiration.",
  pectoralissternal:
    "Flexion, adduction, and internal rotation of the humerus.",
  popliteus:
    "Assists in flexing the leg upon the thigh; when the leg is flexed, it will rotate the tibia inward.",
  quadratuslumborum:
    "Alone(unilateral), lateral flexion of vertebral column; Together (bilateral), depression of thoracic rib cage.",
  quadriceps: "All four quadriceps are powerful extensors of the knee joint.",
  rectusabdominis: "Flex the spinal column or trunk of the body.",
  rhomboids:
    "Pulls scapulae medially, rotates scapulae, holds scapulae into thorax wall.",
  sartorius:
    "Flexion, abduction, and lateral rotation of the hip, flexion of the knee.",
  serratusanterior:
    "Protracts and stabilizes scapula, assists in upward rotation.",
  soleus:
    "Plantarflexion of the foot (that is, they increase the angle between the foot and the leg).",
  splenius:
    "Prime mover for head extension; also allows lateral flexion and rotation of the cervical spine. ",
  sternocleidomastoid:
    "Rotation of the head to the opposite side and flexion of the neck.",
  subscapularis:
    "Rotates the head of the humerus medially (internal rotation) and adducts it; when the arm is raised, it draws the humerus forward and downward.",
  Supinator:
    "Encircling the radius, supinator brings the hand into the supinated position.",
  supraspinatus: "Abduction of arm and stabilization of humerus.",
  tensorfasciaelatae:
    "Assists in keeping the balance of the pelvis while standing, walking, or running.",
  teresmajor: "Assists in the extension and medial rotation of the humerus.",
  teresminor:
    "Modulates the action of the deltoid, preventing the humeral head from sliding upward as the arm is abducted. It also functions to rotate the humerus laterally.",
  tibialisanterior: "Dorsiflex and invert the foot.",
  trapeziuslower: "Depresses the scapulae.",
  trapeziusmiddle: "Moves the scapulae",
  trapeziusupper: "Elevates the scapulae.",
  tricepsbrachii:
    "Responsible for extension of the elbow joint (straightening of the arm).",
  wristextensors: "Extends or opens flat the joints in the hand",
  wristflexors: "Flexes or closes and clenches the joints in the hand",
  "Hip Abductors (listed below)": "",
  "Hip Abductors (opposite)": "",
  "Hip External Rotators (listed below)": "",
  "Hip Internal Rotators (listed below)": "",
  "Longus capitis": "",
  "Longus colli": "",
  "No significant stabilizer": "",
  "No significant stabilizers": "",
  "No significant stabilizers.": "",
  "Rectus capitus": "",
  "See comments": "",
  Back: "",
  General: "",
};

export const definitions = {
  Isometric:
    '"Equal length," so that your muscles do not get longer or shorter by bending a joint.',
  Isotonic:
    '"Equal tension" so that the weight on your muscles stays the same.',
  Isokinetic:
    '"Equal speed" so that your muscles are contracting at the same speed throughout the workout.',
};
