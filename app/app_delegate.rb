class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @percentage_controller = PercentageCalculatorController.alloc
      .initWithDefaultForm
    @navigation_controller = UINavigationController.alloc
      .initWithRootViewController(@percentage_controller)


    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible

    true
  end

end
