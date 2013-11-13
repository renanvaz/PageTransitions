package  
{
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.display.Sprite;
	import pagemanager.PageManager;
	
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Renan Vaz
	 */
	public class Init extends Sprite
	{
		[Embed(source='/../assets/page1.png')]
        public static const BmPage1:Class;
		
		[Embed(source='/../assets/page2.png')]
        public static const BmPage2:Class;
		
		public function Init() 
		{
			PageManager.initTransitions();
			
			var p1:Sprite = new Sprite();
			var p2:Sprite = new Sprite();
			
			p1.addChild(Image.fromBitmap(new BmPage1));
			p2.addChild(Image.fromBitmap(new BmPage2));
			
			p1.addEventListener(TouchEvent.TOUCH, function(e):void{
				var self = e.currentTarget;
				var touch = e.getTouch(self);
				
				if(touch){
					if(touch.phase == TouchPhase.BEGAN){
						PageManager.go('page2');
					}
				}
			});
			
			p2.addEventListener(TouchEvent.TOUCH, function(e):void{
				var self = e.currentTarget;
				var touch = e.getTouch(self);
				
				if(touch){
					if(touch.phase == TouchPhase.BEGAN){
						PageManager.go('page1');
					}
				}
			});
			
			PageManager.main = this;
			
			PageManager.add('page1', p1);
			PageManager.add('page2', p2);
			
			PageManager.go('page1');
		}
		
	}

}