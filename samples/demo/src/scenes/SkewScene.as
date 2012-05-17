package scenes
{
    import starling.animation.Transitions;
    import starling.animation.Tween;
    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.Image;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.Color;
    import starling.utils.deg2rad;

    public class SkewScene extends Scene
    {
        private var mSkewXButton:Button;
		private var mSkewYButton:Button;
        
        private var mEgg:Image;
        private var mTransitions:Array;
        
        public function SkewScene()
        {
            mTransitions = [Transitions.LINEAR, Transitions.EASE_OUT, Transitions.EASE_IN_OUT,
                            Transitions.EASE_OUT_BACK, Transitions.EASE_OUT_BOUNCE,
                            Transitions.EASE_OUT_ELASTIC];
            
            var buttonTexture:Texture = Assets.getTexture("ButtonNormal");
            
            // create a button that starts the tween
            mSkewXButton = new Button(buttonTexture, "SkewX");
            mSkewXButton.addEventListener(Event.TRIGGERED, onButtonClicked);
            mSkewXButton.x = Constants.CenterX - mSkewXButton.width - 10 
            mSkewXButton.y = 20;
            addChild(mSkewXButton);
			
			mSkewYButton = new Button(buttonTexture, "SkewY");
			mSkewYButton.addEventListener(Event.TRIGGERED, onButtonClicked);
			mSkewYButton.x = Constants.CenterX + 10
			mSkewYButton.y = 20;
			addChild(mSkewYButton);
            
             
            // the Starling will be tweened
            mEgg = new Image(Assets.getTexture("StarlingFront"));
            addChild(mEgg);
            resetEgg();
            
        }
        
        private function resetEgg():void
        {
            mEgg.x = 160;
            mEgg.y = 250;
            mEgg.scaleX = mEgg.scaleY = 1.0;
            mEgg.rotation = 0.0;
			mEgg.pivotX = mEgg.width/2;
			mEgg.pivotY = mEgg.height/2;
			mEgg.skewY = 0;  
			mEgg.skewX = 0; 
        }
		
		private function animateSkew(type:String):void
		{
			var tween1:Tween = new Tween(mEgg, 3.5, Transitions.LINEAR);
			tween1.animate(type, deg2rad(30)); 
			
			tween1.onComplete = function():void{ 
				var tween2:Tween = new Tween(mEgg, 3.5, Transitions.LINEAR);
				tween2.animate(type, deg2rad(-30));
				tween2.onComplete = function():void { 
					var tween3:Tween = new Tween(mEgg, 3.5, Transitions.LINEAR);
					tween3.animate(type, deg2rad(0));
					tween3.onComplete = function():void { mSkewXButton.enabled = true; mSkewYButton.enabled = true;}
					Starling.juggler.add(tween3);
					
				};
				Starling.juggler.add(tween2);		
			}
			Starling.juggler.add(tween1);
		}
        
        private function onButtonClicked(event:Event):void
        {
            mSkewXButton.enabled = false;
			mSkewYButton.enabled = false; 
            resetEgg();
			
			if(event.currentTarget == mSkewXButton){
				animateSkew('skewX'); 
			} else if(event.currentTarget == mSkewYButton){
				animateSkew('skewY');
			}
        }
        
        
        public override function dispose():void
        {
            mSkewXButton.removeEventListener(Event.TRIGGERED, onButtonClicked);
			mSkewYButton.removeEventListener(Event.TRIGGERED, onButtonClicked);
            super.dispose();
        }
    }
}