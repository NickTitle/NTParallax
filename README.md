ios-uiview-parallax
===================

engine and container for accelerometer-driven animations

###Pan the phone left and right to check out parallax in the demo app###

![Image](http://i.imgur.com/MJXE7Pg.png&raw=png)
![Image](http://i.imgur.com/qYjhh8g.png&raw=png)
![Image](http://i.imgur.com/TQ7Lvbu.png&raw=png)

Add custom parallax to your apps in just a few small steps:

1. Add CoreMotion to your project
2. Import "NTParallaxStackController.h" to your view controller's header
3. Create an NTParallaxStackController as a property
4. Instantiate the NTParallaxStackController
5. Add NTParallaxLayers to the Stack
6. Add the NTParallaxStackController to your view controller hierarchy

- You can have as many NTParallaxStackControllers as you want.
- Each NTParallaxStackController can have as many NTParallaxLayers as you need.

Note:This is fully functional code, but not measured or optimized yet. Feel free to use now, but watch the repo for updates in the near future.
