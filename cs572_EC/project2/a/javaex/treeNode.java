package com.eyecm.tree;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

/**
 * 树的节点
 * 
 */
public class TreeNode
{
    private int id;
    private TreeNode parent;
    private ArrayList<TreeNode> children;
    private NodeData data;

    public TreeNode(int id, TreeNode parent, ArrayList<TreeNode> children,
            NodeData data)
    {
        super();
        this.id = id;
        this.parent = parent;
        this.children = children;
        this.data = data;
    }

    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public TreeNode getParent()
    {
        return parent;
    }

    public void setParent(TreeNode parent)
    {
        this.parent = parent;
    }

    public ArrayList<TreeNode> getChildren()
    {
        return children;
    }

    public void setChildren(ArrayList<TreeNode> children)
    {
        this.children = children;
    }

    public NodeData getData()
    {
        return data;
    }

    public void setData(NodeData data)
    {
        this.data = data;
    }

    /**
     * 当前节点是否是根节点
     * 
     * @return
     */
    public boolean isRoot()
    {
        if (this.parent == null)
        {
            return true;
        } else
        {
            return false;
        }
    }

    /**
     * 当前节点是否是叶子节点
     * 
     * @return
     */
    public boolean isLeaf()
    {
        if (this.children == null || this.children.size() == 0)
        {
            return true;
        } else
        {
            return false;
        }
    }

    /**
     * 对该节点及其子树进行层次遍历
     * 
     * @param treeNode
     */
    public static void levelTraversal(TreeNode treeNode)
    {
        if (treeNode == null)
        {
            return;
        }
        if (treeNode.isLeaf())
        {
            treeNode.data.output();
        } else
        {
            Queue<TreeNode> queue = new LinkedList<TreeNode>();
            queue.offer(treeNode);
            while (queue.size() > 0)
            {
                TreeNode node = queue.poll();
                node.data.output();

                if (node.isLeaf() == false)
                {
                    for (int i = 0; i < node.children.size(); i++)
                    {
                        queue.offer(node.children.get(i));
                    }
                }
            }
        }
    }

    /**
     * 查找特点的节点，在此使用层次遍历进行查找
     * 
     * @param id
     * @param treeNode
     * @return
     */
    public static TreeNode search(int id, TreeNode treeNode)
    {
        if (treeNode == null)
        {
            return null;
        }
        if (treeNode.isLeaf())
        {
            if (treeNode.id == id)
            {
                return treeNode;
            } else
            {
                return null;
            }
        } else
        {
            Queue<TreeNode> queue = new LinkedList<TreeNode>();
            queue.offer(treeNode);
            while (queue.size() > 0)
            {
                TreeNode node = queue.poll();
                if (node.id == id)
                {
                    return node;
                }

                if (node.isLeaf() == false)
                {
                    for (int i = 0; i < node.children.size(); i++)
                    {
                        queue.offer(node.children.get(i));
                    }
                }
            }

            return null;
        }
    }

    /**
     * 将节点插入为另一个节点的孩子
     * 
     * @param childNode
     * @param toBeAppended
     * @return
     */
    public static boolean appendAsChild(TreeNode childNode,
            TreeNode toBeAppended)
    {
        if (childNode == null || toBeAppended == null)
        {
            return false;
        } else
        {
            if (toBeAppended.isLeaf())
            {
                ArrayList<TreeNode> children = new ArrayList<TreeNode>();
                children.add(childNode);
                toBeAppended.children = children;
            } else
            {
                toBeAppended.children.add(childNode);
            }

            return true;
        }
    }

    /**
     * 将节点插入为另一个节点的兄弟
     * 
     * @param sublingNode
     * @param toBeAppended
     * @return
     */
    public static boolean appendAsSubling(TreeNode sublingNode,
            TreeNode toBeAppended)
    {
        if (sublingNode == null || toBeAppended == null)
        {
            return false;
        } else
        {
            // 单根树，无法对根节点添加兄弟
            if (toBeAppended.isRoot() == true)
            {
                return false;
            } else
            {
                toBeAppended.parent.children.add(sublingNode);
                return true;
            }
        }
    }
}
