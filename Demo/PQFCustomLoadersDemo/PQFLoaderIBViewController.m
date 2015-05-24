#import "PQFLoaderIBViewController.h"
#import "PQFBouncingBalls.h"

@interface PQFLoaderIBViewController ()
@property (weak, nonatomic) IBOutlet PQFBouncingBalls *loader;

@end

@implementation PQFLoaderIBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.loader showLoader];
}

@end
