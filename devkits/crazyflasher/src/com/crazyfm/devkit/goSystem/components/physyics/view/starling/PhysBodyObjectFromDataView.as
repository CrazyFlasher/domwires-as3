/**
 * Created by Anton Nefjodov on 17.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.view.starling
{
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.units.VertexDataVo;

	import flash.geom.Matrix;
	import flash.geom.Point;

	import nape.geom.Mat23;

	import starling.display.DisplayObjectContainer;
	import starling.display.Shape;
	import starling.display.Sprite;

	public class PhysBodyObjectFromDataView extends AbstractPhysBodyObjectView
	{
		private var shapesDataList:Vector.<ShapeDataVo>;
		private var color:uint;

		public function PhysBodyObjectFromDataView(viewContainer:DisplayObjectContainer, shapesDataList:Vector.<ShapeDataVo>, color:uint = 0x666666)
		{
			super(viewContainer);

			this.shapesDataList = shapesDataList;
			this.color = color;
		}

		override protected function drawSkin():void
		{
			var skin:Sprite = _skin as Sprite;
			var shape:Shape = new Shape();
			skin.addChild(shape);

			shape.graphics.lineStyle(2, color);

			var p:Point;
			var m:Matrix;

			var shapeData:ShapeDataVo;
			var vertexData:VertexDataVo;

			for each (shapeData in shapesDataList)
			{
				m = Mat23.rotation(shapeData.angle).concat(Mat23.translation(shapeData.x, shapeData.y)).toMatrix();

				if (isNaN(shapeData.radius))
				{
					p = m.transformPoint(new Point(shapeData.vertexDataList[0].x, shapeData.vertexDataList[0].y));

					shape.graphics.moveTo(p.x, p.y);

					for (var i:int = 1; i < shapeData.vertexDataList.length; i++)
					{
						vertexData = shapeData.vertexDataList[i];
						p = m.transformPoint(new Point(vertexData.x, vertexData.y));
						shape.graphics.lineTo(p.x, p.y);
					}

					p = m.transformPoint(new Point(shapeData.vertexDataList[0].x, shapeData.vertexDataList[0].y));

					shape.graphics.lineTo(p.x, p.y);
				}else
				{
					shape.graphics.drawCircle(shapeData.x, shapeData.y, shapeData.radius);
				}
			}
		}
	}
}
