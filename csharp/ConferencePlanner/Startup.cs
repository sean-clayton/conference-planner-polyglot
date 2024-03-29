﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ConferencePlanner.Data;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Swashbuckle.AspNetCore.Swagger;

namespace ConferencePlanner {
  public class Startup {
    public Startup (IConfiguration configuration) {
      Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    // This method gets called by the runtime. Use this method to add services to the container.
    public void ConfigureServices (IServiceCollection services) {
      services
        .AddDbContext<ApplicationDbContext> (options =>
          options
          .UseNpgsql (Configuration.GetConnectionString ("DefaultConnection")));

      services
        .AddMvc ()
        .SetCompatibilityVersion (CompatibilityVersion.Version_2_2);

      services
        .AddSwaggerGen (options =>
          options
          .SwaggerDoc ("v1",
            new Info { Title = "Conference Planner API", Version = "v1" }));
    }

    // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
    public void Configure (IApplicationBuilder app, IHostingEnvironment env) {
      app.UseSwagger ();

      app
        .UseSwaggerUI (options =>
          options.SwaggerEndpoint ("/swagger/v1/swagger.json",
            "Conference Planner API v1"));

      if (env.IsDevelopment ()) {
        app.UseDeveloperExceptionPage ();
      } else {
        // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
        app.UseHsts ();
      }

      app.UseHttpsRedirection ();
      app.UseMvc ();

      app.Run (ctx => {
        ctx.Response.Redirect ("/swagger");
        return Task.CompletedTask;
      });
    }
  }
}
