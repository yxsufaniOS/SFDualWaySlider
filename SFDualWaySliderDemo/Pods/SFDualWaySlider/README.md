# SFDualWaySlider



双向滑块


![](https://github.com/yxsufaniOS/SFDualWaySlider/blob/master/图示.png)

## 安装

To use SFDualWaySlider add the following to your Podfile

pod 'SFDualWaySlider'

or 

或者直接把“SFDualWaySlider”文件夹拉到项目中.

# 使用
````
SFDualWaySlider *slider = [[SFDualWaySlider alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 70) minValue:0 maxValue:80 blockSpaceValue:2];
slider.progressRadius = 5;
[slider.minIndicateView setTitle:@"不限"];
[slider.maxIndicateView setTitle:@"不限"];
slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {


};

slider.getMinTitle = ^NSString *(CGFloat minValue) {
   if (floor(minValue) == 0.f) {
       return @"不限";
   }else{
       return [NSString stringWithFormat:@"%.fK",floor(minValue)];
   }  

};

slider.getMaxTitle = ^NSString *(CGFloat maxValue) {
   if (floor(maxValue) == 80.f) {
      return @"不限";
   }else{
      return [NSString stringWithFormat:@"%.fK",floor(maxValue)];
   }
};

````

