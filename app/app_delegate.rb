class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @percentageCalculatorController = PercentageCalculatorController.alloc
      .initWithNibName(nil, bundle: nil)
    @navigationController = UINavigationController.alloc
      .initWithRootViewController(@percentageCalculatorController)

    @window.rootViewController = @navigationController
    @window.makeKeyAndVisible

    true
  end
end
