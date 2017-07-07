using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BasicCascadingDropdowns.Startup))]
namespace BasicCascadingDropdowns
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
