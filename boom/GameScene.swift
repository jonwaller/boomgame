import SpriteKit
import UIKit

class GameScene: SKScene {
    
    let sprite = SKSpriteNode(imageNamed:"Spaceship")

    override func didMoveToView(view: SKView) {

        sprite.xScale = 0.05
        sprite.yScale = 0.05
        sprite.position = CGPoint(x:0,y:0);
        
        self.addChild(sprite)

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        var fingerNumber=0
        var x0, y0:Double
        var y1, x1:Double
        var x, y:Double
        
        x0=0;
        y0=0;
        
        for touch:AnyObject in touches{
                
                if (fingerNumber==0){
                
                    let location = touch.locationInNode(self)
                    x0=(Double)(location.x)
                    y0=(Double)(location.y)
                    let action = SKAction.moveTo(location,duration:0.5)
                    sprite.runAction(action)
                
                }else if (fingerNumber==1){
                
                    let location = touch.locationInNode(self)
                    x1=(Double)(location.x)
                    y1=(Double)(location.y)
                    
                    x=(x1-x0)
                    y=(y1-y0)
                    
                    let orientation = CGFloat(UIKit.atan(x/y))
                    
                    let action = SKAction.rotateToAngle(-orientation, duration: 0.1, shortestUnitArc: true)
                    sprite.runAction(action)
                }

                fingerNumber=fingerNumber+1;
                
            }

    }
   
    override func update(currentTime: CFTimeInterval) {

    }
}
