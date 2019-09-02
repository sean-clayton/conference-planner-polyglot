using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

namespace ConferencePlanner.Migrations {
  public partial class initial : Migration {
    protected override void Up (MigrationBuilder migrationBuilder) {
      migrationBuilder
        .CreateTable (name: "Speakers",
          columns : table =>
          new {
            ID =
              table
              .Column<int> (nullable: false)
              .Annotation ("Npgsql:ValueGenerationStrategy",
                NpgsqlValueGenerationStrategy.SerialColumn),
              Name = table.Column<string> (maxLength: 200, nullable: false),
              Bio = table.Column<string> (maxLength: 4000, nullable: true),
              WebSite = table.Column<string> (maxLength: 1000, nullable: true)
          },
          constraints : table => {
            table.PrimaryKey ("PK_Speakers", x => x.ID);
          });
    }

    protected override void Down (MigrationBuilder migrationBuilder) {
      migrationBuilder.DropTable (name: "Speakers");
    }
  }
}