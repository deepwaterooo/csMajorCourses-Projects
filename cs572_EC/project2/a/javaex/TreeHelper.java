package com.eyecm.tree;

/**
 * 辅助工具类
 * 
 */
public class TreeHelper
{
    int id;

    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public static void main(String[] args)
    {
        NodeData root = new NodeData("root", "this is root");

        NodeData n1_1 = new NodeData("n1_1", "level 1");
        NodeData n1_2 = new NodeData("n1_2", "level 1");

        NodeData n2_1 = new NodeData("n2_1", "level 2,n1_1 child");
        NodeData n2_2 = new NodeData("n2_2", "level 2,n1_1 child");
        NodeData n2_3 = new NodeData("n2_3", "level 2,n1_2 child");
        NodeData n2_4 = new NodeData("n2_4", "level 2,n1_2 child");

        NodeData n3_1 = new NodeData("n3_1", "level 3,n2_2 child");

        TreeNode rootNode = new TreeNode(0, null, null, root);

        TreeNode n1_1_node = new TreeNode(1, null, null, n1_1);
        TreeNode n1_2_node = new TreeNode(2, null, null, n1_2);
        TreeNode.appendAsChild(n1_1_node, rootNode);
        TreeNode.appendAsChild(n1_2_node, rootNode);

        TreeNode n2_1_node = new TreeNode(4, null, null, n2_1);
        TreeNode n2_2_node = new TreeNode(5, null, null, n2_2);
        TreeNode.appendAsChild(n2_1_node, n1_1_node);
        TreeNode.appendAsChild(n2_2_node, n1_1_node);

        TreeNode n2_3_node = new TreeNode(6, null, null, n2_3);
        TreeNode n2_4_node = new TreeNode(7, null, null, n2_4);
        TreeNode.appendAsChild(n2_3_node, n1_2_node);
        TreeNode.appendAsChild(n2_4_node, n1_2_node);

        TreeNode n3_1_node = new TreeNode(13, null, null, n3_1);
        TreeNode.appendAsChild(n3_1_node, n2_2_node);
    
        TreeNode.levelTraversal(TreeNode.search(5, rootNode));
    }
}
