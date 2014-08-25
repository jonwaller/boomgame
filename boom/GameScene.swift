import SpriteKit
import UIKit

class GameScene: SKScene {
    
    let spaceshipSprite = SKSpriteNode(imageNamed:"Spaceship")
    
    var hasFinger0Location=false
    var hasFinger1Location=false
    var finger0Location=CGPoint(x:0,y:0)
    var finger1Location=CGPoint(x:0,y:0)
    
    var spaceshipLocation=CGPoint(x:0,y:0)
    
    func initGame(){
        spaceshipSprite.xScale = 0.1
        spaceshipSprite.yScale = 0.1
        spaceshipSprite.position=spaceshipLocation
        
        self.addChild(spaceshipSprite)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
            selector: Selector("weaponFireTick"), userInfo: nil, repeats: true)
    }
    
    var missiles:SKSpriteNode[]=[]
    
    func weaponFireTick(){
        
        if hasFinger0Location {
        
        let orb = SKSpriteNode(imageNamed:"orb")
        
        orb.xScale = 0.05
        orb.yScale = 0.05
        orb.zRotation = spaceshipSprite.zRotation
        orb.position=spaceshipLocation
        
        missiles.append(orb);
        self.addChild(orb)
        
        //missiles.removeAtIndex(0)
        
        }

    }
    
    override func didMoveToView(view: SKView) {
        initGame()
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        touchesMoved(touches, withEvent: event)
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
    
    override func update(currentTime: CFTimeInterval) {
        
        if (hasFinger0Location){

            spaceshipLocation.x+=(finger0Location.x-spaceshipLocation.x)/30
            spaceshipLocation.y+=(finger0Location.y-spaceshipLocation.y)/30
        
            var xDiff=(Double)(finger0Location.x-spaceshipLocation.x)
            var yDiff=(Double)(finger0Location.y-spaceshipLocation.y)
            
            if(hasFinger1Location){
                
                xDiff=(Double)(finger1Location.x-spaceshipLocation.x)
                yDiff=(Double)(finger1Location.y-spaceshipLocation.y)
                
            }
            
            var orientation = CGFloat(UIKit.atan2(xDiff, yDiff))
            var action = SKAction.rotateToAngle(-orientation,duration:0);
            
            spaceshipSprite.runAction(action)
            
            if UIKit.sqrt(pow(xDiff,2)+pow(yDiff,2))<20{
                hasFinger0Location=false
                hasFinger1Location=false
            }
            
        }
        
        spaceshipSprite.position = spaceshipLocation
        
        
        for missile in missiles{
            
            var currentRotation:CDouble=CDouble(missile.zRotation)
            
            missile.position.x-=CGFloat(UIKit.sin(currentRotation))*20
            missile.position.y+=CGFloat(UIKit.cos(currentRotation))*20
        }
    }
}
