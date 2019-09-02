using System.Linq;

namespace ConferencePlanner.Data {
  public static class EntityExtensions {
    public static ConferenceDTO.SpeakerResponse MapSpeakerResponse (this Speaker speaker) =>
      new ConferenceDTO.SpeakerResponse {
        ID = speaker.ID,
        Name = speaker.Name,
        Bio = speaker.Bio,
        WebSite = speaker.WebSite,
        Sessions = speaker.SessionSpeakers?
        .Select (ss =>
        new ConferenceDTO.Session {
        ID = ss.SessionId,
        Title = ss.Session.Title
        })
        .ToList ()
      };
  }
}
