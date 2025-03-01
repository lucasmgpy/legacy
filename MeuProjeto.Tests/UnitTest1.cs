using Xunit;
using MeuProjeto.Controllers;
using Microsoft.AspNetCore.Mvc;

namespace MeuProjeto.Tests
{
    public class HomeControllerTests
    {
        [Fact]
        public void Index_ReturnsViewResult()
        {
            // Arrange
            var controller = new HomeController(null);

            // Act
            var result = controller.Index();

            // Assert
            Assert.IsType<ViewResult>(result);
        }
    }
}
