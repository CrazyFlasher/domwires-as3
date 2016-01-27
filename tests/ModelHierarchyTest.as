/**
 * Created by Anton Nefjodov
 */
package {
import com.crazy.mvc.Context;
import com.crazy.mvc.Model;
import com.crazy.mvc.ModelContainer;
import com.crazy.mvc.api.IContext;
import com.crazy.mvc.api.IModel;
import com.crazy.mvc.api.IModelContainer;

import flexunit.framework.Assert;

public class ModelHierarchyTest {

        [Test]
        public function testParents():void
        {
            var c1:IContext = new Context();
            var c2:IContext = new Context();
            var mc1:IModelContainer = new ModelContainer();
            var mc2:IModelContainer = new ModelContainer();
            var m:IModel = new Model();

            mc2.addModel(m);
            Assert.assertEquals(m.parent, mc2);

            mc1.addModel(mc2);
            Assert.assertEquals(mc2.parent, mc1);
            Assert.assertEquals(m.parent.parent, mc1);

            c2.addModel(mc1);
            Assert.assertEquals(mc1.parent, c2);
            Assert.assertEquals(mc2.parent.parent, c2);
            Assert.assertEquals(m.parent.parent.parent, c2);

            c1.addModel(c2);
            Assert.assertEquals(c2.parent, c1);
            Assert.assertEquals(mc1.parent.parent, c1);
            Assert.assertEquals(mc2.parent.parent.parent, c1);
            Assert.assertEquals(m.parent.parent.parent.parent, c1);
        }
    }
}
