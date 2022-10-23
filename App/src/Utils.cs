static class Utils
{
  public static bool IsDevelopmentServer()
  {
    return Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == "Development";
  }

  public static bool IsProductionServer()
  {
    return !IsDevelopmentServer();
  }
}
