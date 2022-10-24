using Microsoft.AspNetCore.Authentication.Certificate;

var builder = WebApplication.CreateBuilder(args);

if (Utils.IsProductionServer())
{
  builder.WebHost.UseUrls("https://localhost:443");

  builder.Services.AddAuthentication(
        CertificateAuthenticationDefaults.AuthenticationScheme)
    .AddCertificate();
}

var app = builder.Build();

if (Utils.IsProductionServer())
{
  app.UseAuthentication();
}

app.UseDefaultFiles();
app.UseStaticFiles();

app.MapGet("/a", () => "Hello World!");

app.Run();
