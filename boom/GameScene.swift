import SpriteKit
import UIKit

class GameScene: SKScene {
    
    let spaceshipSprite = SKSpriteNode(imageNamed:"Spaceship")
    
    var hasFinger0Location=false
    var hasFinger1Location=false
    var finger0Location=CGPoint(x:0,y:0)
    var finger1Location=CGPoint(x:0,y:0)
    
    var spaceshipLocation=CGPoint(x:0,y:0)
    
    override func didMoveToView(view: SKView) {
        
        spaceshipSprite.xScale = 0.05
        spaceshipSprite.yScale = 0.05
        spaceshipSprite.position=spaceshipLocation
        
        self.addChild(spaceshipSprite)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        hasFinger0Location=false
        hasFinger1Location=false
        
        var fingerCounter=0
        
        for touch:AnyObject in touches{
            
            if (fingerCounter==0){
                finger0Location = touch.locationInNode(self)
                hasFinger0Location=true
            }else if (fingerCounter==1){
                finger1Location = touch.locationInNode(self)
                hasFinger1Location=true
            }
            
            fingerCounter=fingerCounter+1
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        hasFinger0Location=false
        hasFinger1Location=false
        
        var fingerCounter=0
        
        for touch:AnyObject in touches{
            
            if (fingerCounter==0){
                finger0Location = touch.locationInNode(self)
                hasFinger0Location=true
            }else if (fingerCounter==1){
                finger1Location = touch.locationInNode(self)
                hasFinger1Location=true
            }
            
            fingerCounter=fingerCounter+1
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        hasFinger0Location=false
        hasFinger1Location=false
        
        var fingerCounter=0
        
        for touch:AnyObject in touches{
            
            if (fingerCounter==0){
                finger0Location = touch.locationInNode(self)
                hasFinger0Location=true
            }else if (fingerCounter==1){
                finger1Location = touch.locationInNode(self)
                hasFinger1Location=true
            }
            
            fingerCounter=fingerCounter+1
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        
        if (!hasFinger0Location && !hasFinger1Location){
            //No fingers - Newton's first law
            
        }else if (hasFinger0Location && !hasFinger1Location){
            
            //Move + rotate same finger
            
            spaceshipLocation.x+=(finger0Location.x-spaceshipLocation.x)/10
            spaceshipLocation.y+=(finger0Location.y-spaceshipLocation.y)/10
            
            var xDiff=(Double)(spaceshipLocation.x-finger0Location.x)
            var yDiff=(Double)(spaceshipLocation.y-finger0Location.y)
            
            let orientation = CGFloat(UIKit.atan(xDiff/yDiff))
            
            let action = SKAction.rotateToAngle(-orientation, duration: 0)
            spaceshipSprite.runAction(action)
            
        }else if (hasFinger0Location && hasFinger1Location){
            
            //Move(finger0) + rotate(finger1)
            
            spaceshipLocation.x+=(finger0Location.x-spaceshipLocation.x)/10
            spaceshipLocation.y+=(finger0Location.y-spaceshipLocation.y)/10
            
            var xDiff=(Double)(finger1Location.x-finger0Location.x)
            var yDiff=(Double)(finger1Location.y-finger0Location.y)
            
            let orientation = CGFloat(UIKit.atan(xDiff/yDiff))
            
            let action = SKAction.rotateToAngle(-orientation, duration: 0)
            spaceshipSprite.runAction(action)
        }
        
        //spaceshipLocation.x+=spaceshipXv
        //spaceshipLocation.y+=spaceshipYv
        
        spaceshipSprite.position = spaceshipLocation
        
    }
}
