var builder = WebApplication.CreateBuilder(args);

if (Utils.IsProductionServer())
{
  builder.WebHost.UseUrls("https://localhost:443");
}

var app = builder.Build();

app.MapGet("/", () => "Hello World!");

app.Run();
