using System.IO;
using System.Threading.Tasks;

namespace ConferencePlanner.Data {
  public abstract class DataLoader {
    public abstract Task LoadDataAsync (string conferenceName, Stream fileStream, ApplicationDbContext db);
  }
}
