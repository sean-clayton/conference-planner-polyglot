using System.Collections.Generic;

namespace ConferencePlanner.Data {
  public class Speaker : ConferenceDTO.Speaker {
    public virtual ICollection<SessionSpeaker> SessionSpeakers { get; set; } = new List<SessionSpeaker> ();
  }
}
